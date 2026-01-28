import QtQuick

Item {
    id: root
    property alias text: label.text
    property int style: 0
    property color color: "white"

    Text {
        id: label
        text: ""
        color: root.color
        font.pixelSize: 14
    }

    // Note: original project exposes Typography.Style constants; this shim
    // uses numeric style values directly (0=Subtitle, 1=Caption).
}
