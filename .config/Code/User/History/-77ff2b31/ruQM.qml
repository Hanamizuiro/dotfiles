import QtQuick

pragma Singleton

QtObject {
    id: SettingsData

    // small defaults to avoid runtime undefined errors
    property int dankBarSpacing: 0
    property var controlCenterWidgets: []

    signal controlCenterWidgetsChanged()
}
