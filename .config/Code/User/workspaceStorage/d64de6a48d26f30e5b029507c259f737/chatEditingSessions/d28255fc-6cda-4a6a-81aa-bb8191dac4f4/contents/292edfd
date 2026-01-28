import QtQuick

Rectangle {
    id: root
    property int buttonSize: 36
    property string iconName: ""
    property int iconSize: 16
    property color iconColor: "white"
    property color backgroundColor: "transparent"

    width: buttonSize
    height: buttonSize
    radius: buttonSize / 2
    color: backgroundColor

    MouseArea { anchors.fill: parent; onClicked: root.clicked() }

    signal clicked()
}
