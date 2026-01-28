import QtQuick

Column {
    id: root
    property var model: null
    spacing: Theme.spacingS

    Repeater {
        model: model ? (model.controlCenterWidgets || []) : []
        delegate: Rectangle {
            width: parent.width
            height: 40
            color: "transparent"
            Text { text: modelData.id || "widget"; anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 6 }
        }
    }
}
