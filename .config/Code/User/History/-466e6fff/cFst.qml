import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 900; height: 600

    Loader {
        anchors.fill: parent
        source: "modules/dank/ControlCenter/ControlCenterPopout.qml"
    }
}
