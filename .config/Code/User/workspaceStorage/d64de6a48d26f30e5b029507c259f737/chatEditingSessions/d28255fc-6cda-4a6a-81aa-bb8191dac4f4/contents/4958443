import QtQuick

Item {
    id: root

    // properties expected by ControlCenterPopout
    property string layerNamespace: ""
    property int popupWidth: 400
    property int popupHeight: 400
    property real triggerX: 0
    property real triggerY: 0
    property int triggerWidth: 0
    property string positioning: ""
    property var triggerScreen: null
    property bool shouldBeVisible: false
    property bool visible: shouldBeVisible
    property Component content: null

    signal lockRequested()

    Loader {
        id: contentLoader
        anchors.fill: parent
        sourceComponent: root.content
    }
}
