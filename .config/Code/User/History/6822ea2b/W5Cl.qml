import QtQuick

QtObject {
    id: Theme

    readonly property real spacingL: 16
    readonly property real spacingM: 12
    readonly property real spacingS: 8
    readonly property real spacingXS: 4

    readonly property real popupTransparency: 0.88
    readonly property real cornerRadius: 8
    readonly property real barHeight: 48
    readonly property real iconSize: 20

    // basic color tokens
    readonly property color surfaceContainerHigh: Qt.rgba(0.14, 0.14, 0.14, 1)
    readonly property color surfaceText: Qt.rgba(1,1,1,1)
    readonly property color surfaceVariantText: Qt.rgba(0.8,0.8,0.8,1)
    readonly property color primary: Qt.rgba(0.2,0.6,0.86,1)
    readonly property color outline: Qt.rgba(0,0,0,1)

    function withAlpha(color, a) {
        // accept a QColor or numeric rgba; fall back to provided value
        try {
            return Qt.rgba(color.r, color.g, color.b, a)
        } catch (e) {
            return color
        }
    }
}
