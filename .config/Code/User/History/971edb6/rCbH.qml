import QtQuick

QtObject {
    id: network
    // Minimal network service shim
    property bool wifiEnabled: false
    property var activeService: ({ autoRefreshEnabled: false })
}
