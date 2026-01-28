import QtQuick

pragma Singleton

QtObject {
    id: UserInfoService

    property string fullName: "User"
    property string username: "user"
    property string uptime: ""

    function getUptime() {
        // lightweight stub: set a simple uptime string
        uptime = "0h 0m"
    }
}
