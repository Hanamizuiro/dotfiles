import QtQuick

pragma Singleton

QtObject {
    id: NetworkService

    property bool wifiAvailable: true
    property bool wifiEnabled: false
    property bool wifiToggling: false
    property string networkStatus: "wifi"
    property string wifiSignalIcon: "wifi"
    property int wifiSignalStrength: 0
    property bool wifiConnected: false
    property bool ethernetConnected: false
    property string currentWifiSSID: ""

    function toggleWifi() {
        wifiToggling = true
        // no-op stub
        wifiToggling = false
    }
}
