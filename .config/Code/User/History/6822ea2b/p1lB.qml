import QtQuick

QtObject {
    // Minimal Theme shim used by ControlCenterPopout
    property color surfaceContainerHigh: "#222222"
    property real popupTransparency: 0.85
    property color surfaceContainer: "#101010"
    property color outline: "#999999"
    property real cornerRadius: 8
    property real spacingL: 16
    property real spacingM: 12
    property real spacingS: 8
    property real barHeight: 32
    // color helper placeholders
    function withAlpha(col, a) {
        return col // quick stub; ControlCenter uses Theme.withAlpha only for color composition
    }
}
