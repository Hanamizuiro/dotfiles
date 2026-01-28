import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent

    Loader {
        id: inner
        anchors.fill: parent
        source: "file:///home/blueflowers/.config/quickshell/modules/dank/ControlCenter/Details/AudioOutputDetail.qml"
    }
}
