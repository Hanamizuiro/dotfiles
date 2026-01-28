import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets


DankPopout {
    id: root

    layerNamespace: "dms:control-center"

    property string expandedSection: ""
    property var triggerScreen: null
    property bool editMode: false
    property int expandedWidgetIndex: -1
    property var expandedWidgetData: null

    signal lockRequested

    function collapseAll() {
        expandedSection = ""
        expandedWidgetIndex = -1
        expandedWidgetData = null
    }

    onEditModeChanged: {
        if (editMode) {
            collapseAll()
        }
    }

    onVisibleChanged: {
        if (!visible) {
            collapseAll()
        }
    }

    readonly property color _containerBg: Theme.withAlpha(Theme.surfaceContainerHigh, Theme.popupTransparency)

    function setTriggerPosition(x, y, width, section, screen) {
        StateUtils.setTriggerPosition(root, x, y, width, section, screen)
    }

    function openWithSection(section) {
        StateUtils.openWithSection(root, section)
    }

    function toggleSection(section) {
        StateUtils.toggleSection(root, section)
    }

    popupWidth: 550
    popupHeight: Math.min((triggerScreen?.height ?? 1080) - 100, contentLoader.item && contentLoader.item.implicitHeight > 0 ? contentLoader.item.implicitHeight + 20 : 400)
    triggerX: (triggerScreen?.width ?? 1920) - 600 - Theme.spacingL
    triggerY: Theme.barHeight - 4 + SettingsData.dankBarSpacing
    triggerWidth: 80
    positioning: ""
    screen: triggerScreen
    shouldBeVisible: false
    visible: shouldBeVisible

    onShouldBeVisibleChanged: {
        if (shouldBeVisible) {
            Qt.callLater(() => {
                             if (NetworkService.activeService) {
                                 NetworkService.activeService.autoRefreshEnabled = NetworkService.wifiEnabled
                             }
                             if (UserInfoService)
                             UserInfoService.getUptime()
                         })
        } else {
            Qt.callLater(() => {
                             if (NetworkService.activeService) {
                                 NetworkService.activeService.autoRefreshEnabled = false
                             }
                             if (BluetoothService.adapter && BluetoothService.adapter.discovering)
                             BluetoothService.adapter.discovering = false
                             editMode = false
                         })
        }
    }

    WidgetModel {
        id: widgetModel
    }

    content: Component {
        Rectangle {
            id: controlContent

            implicitHeight: mainColumn.implicitHeight + Theme.spacingM
            property alias bluetoothCodecSelector: bluetoothCodecSelector

            color: {
                const transparency = Theme.popupTransparency
                const surface = Theme.surfaceContainer || Qt.rgba(0.1, 0.1, 0.1, 1)
                return Qt.rgba(surface.r, surface.g, surface.b, transparency)
            }
            radius: Theme.cornerRadius
            border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.08)
            border.width: 0
            antialiasing: true
            smooth: true

            Column {
                id: mainColumn
                width: parent.width - Theme.spacingL * 2
                x: Theme.spacingL
                y: Theme.spacingL
                spacing: Theme.spacingS

                HeaderPane {
                    id: headerPane
                    width: parent.width
                    editMode: root.editMode
                    onEditModeToggled: root.editMode = !root.editMode
                    onPowerButtonClicked: {
                        if (powerMenuModalLoader) {
                            powerMenuModalLoader.active = true
                            if (powerMenuModalLoader.item) {
                                const popoutPos = controlContent.mapToItem(null, 0, 0)
                                const bounds = Qt.rect(popoutPos.x, popoutPos.y, controlContent.width, controlContent.height)
                                powerMenuModalLoader.item.openFromControlCenter(bounds, root.triggerScreen)
                            }
                        }
                    }
                    onLockRequested: {
                        root.close()
                        root.lockRequested()
                    }
                    onSettingsButtonClicked: {
                        root.close()
                    }
                }

                DragDropGrid {
                    id: widgetGrid
                    width: parent.width
                    editMode: root.editMode
                    expandedSection: root.expandedSection
                    expandedWidgetIndex: root.expandedWidgetIndex
                    expandedWidgetData: root.expandedWidgetData
                    model: widgetModel
                    bluetoothCodecSelector: bluetoothCodecSelector
                    colorPickerModal: root.colorPickerModal
                    screenName: root.triggerScreen?.name || ""
                    parentScreen: root.triggerScreen
                    onExpandClicked: (widgetData, globalIndex) => {
                                         root.expandedWidgetIndex = globalIndex
                                         root.expandedWidgetData = widgetData
                                         if (widgetData.id === "diskUsage") {
                                             root.toggleSection("diskUsage_" + (widgetData.instanceId || "default"))
                                         } else if (widgetData.id === "brightnessSlider") {
                                             root.toggleSection("brightnessSlider_" + (widgetData.instanceId || "default"))
                                         } else {
                                             root.toggleSection(widgetData.id)
                                         }
                                     }
                    onRemoveWidget: index => widgetModel.removeWidget(index)
                    onMoveWidget: (fromIndex, toIndex) => widgetModel.moveWidget(fromIndex, toIndex)
                    onToggleWidgetSize: index => widgetModel.toggleWidgetSize(index)
                    onCollapseRequested: root.collapseAll()
                }

                EditControls {
                    width: parent.width
                    visible: editMode
                    popoutContent: controlContent
                    availableWidgets: {
                        if (!editMode)
                            return []
                        const existingIds = (SettingsData.controlCenterWidgets || []).map(w => w.id)
                        const allWidgets = widgetModel.baseWidgetDefinitions.concat(widgetModel.getPluginWidgets())
                        return allWidgets.filter(w => w.allowMultiple || !existingIds.includes(w.id))
                    }
                    onAddWidget: widgetId => widgetModel.addWidget(widgetId)
                    onResetToDefault: () => widgetModel.resetToDefault()
                    onClearAll: () => widgetModel.clearAll()
                }
            }

            Item {
                id: bluetoothCodecSelector
                anchors.fill: parent
                z: 10000

                // Dynamic wrapper that loads the local stub implementation
                // and proxies the expected API (show/hide and codecSelected signal).
                signal codecSelected(string deviceAddress, string codecName)
                property var _inner: null

                function show(device) {
                    if (_inner && typeof _inner.show === 'function') {
                        _inner.show(device)
                        return
                    }
                    // If inner not ready yet, create it synchronously
                    _createInner(() => { if (_inner && typeof _inner.show === 'function') _inner.show(device) })
                }

                function hide() {
                    if (_inner && typeof _inner.hide === 'function') {
                        _inner.hide()
                    }
                }

                function _createInner(callback) {
                    if (_inner) {
                        if (callback) callback()
                        return
                    }
                    var path = "file:///home/blueflowers/.config/quickshell/qs/Modules/ControlCenter/Details/BluetoothCodecSelector.qml"
                    var comp = Qt.createComponent(path)
                    if (comp.status === Component.Ready) {
                        var inst = comp.createObject(bluetoothCodecSelector)
                        if (inst) {
                            // Ensure it fills the wrapper
                            try { inst.anchors.fill = bluetoothCodecSelector } catch (e) {}
                            inst.z = 10000
                            _inner = inst
                            // Forward inner's codecSelected to wrapper's signal
                            if (typeof inst.codecSelected === 'function' || inst.codecSelected) {
                                try {
                                    inst.codecSelected.connect(function(deviceAddress, codecName) {
                                        bluetoothCodecSelector.codecSelected(deviceAddress, codecName)
                                    })
                                } catch (e) {
                                    // ignore connection failures on stubbed implementations
                                }
                            }
                        }
                    } else {
                        console.log('BluetoothCodecSelector component failed to load:', comp.errorString())
                    }
                    if (callback) callback()
                }

                Component.onCompleted: {
                    // Pre-create the inner stub so subsequent calls are immediate.
                    _createInner()
                }
            }
        }
    }

    Component {
        id: networkDetailComponent
        NetworkDetail {}
    }

    Component {
        id: bluetoothDetailComponent
        BluetoothDetail {
            id: bluetoothDetail
            onShowCodecSelector: function (device) {
                if (contentLoader.item && contentLoader.item.bluetoothCodecSelector) {
                    contentLoader.item.bluetoothCodecSelector.show(device)
                    contentLoader.item.bluetoothCodecSelector.codecSelected.connect(function (deviceAddress, codecName) {
                        bluetoothDetail.updateDeviceCodecDisplay(deviceAddress, codecName)
                    })
                }
            }
        }
    }

    Component {
        id: audioOutputDetailComponent
        AudioOutputDetail {}
    }

    Component {
        id: audioInputDetailComponent
        AudioInputDetail {}
    }

    Component {
        id: batteryDetailComponent
        BatteryDetail {}
    }

    property var colorPickerModal: null
    property var powerMenuModalLoader: null
}
