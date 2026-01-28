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

    // Provide an enum-like holder for style access by consumers
    QtObject {
        id: enumHolder
        readonly property int Style: 0
        // consumers reference Typography.Style.Subtitle etc; provide nested object fallback
        property var StyleObj: ({ Subtitle: 0, Caption: 1 })
    }
}
