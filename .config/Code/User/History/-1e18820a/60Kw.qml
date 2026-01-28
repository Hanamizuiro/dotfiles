import QtQuick

QtObject {
    id: bt
    // Minimal BluetoothService shim
    property var adapter: ({ discovering: false })
}
