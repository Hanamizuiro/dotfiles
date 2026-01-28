import QtQuick

Item {
    id: root
    property alias availableWidgets: root.availableWidgets
    property bool visible: false
    property Component popoutContent: null

    function onAddWidget(widgetId) {}
    function onResetToDefault() {}
    function onClearAll() {}

    // Minimal placeholder UI
    Rectangle {
        anchors.fill: parent
        color: "transparent"
    }
}
