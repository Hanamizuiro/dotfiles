//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import "./modules/common/"
import "./modules/overview/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "./services/"

ShellRoot {
    // Enable/disable modules here. False = not loaded at all, so rest assured
    // no unnecessary stuff will take up memory if you decide to only use, say, the overview.
    property bool enableOverview: true
    property string wallpaperTimestamp: ""

    // Background wallpaper (bound to Appearance.background_image)
    Image {
        id: quickshellWallpaper
        anchors.fill: parent
        // Ensure absolute paths are prefixed with file:// for QML Image
        property string bgSource: Appearance.background_image === undefined || Appearance.background_image === null || Appearance.background_image === "" ? "" : (Appearance.background_image.indexOf("file://") === 0 ? Appearance.background_image : "file://" + Appearance.background_image)
        source: bgSource + (wallpaperTimestamp !== "" ? ("?t=" + wallpaperTimestamp) : "")
        fillMode: Image.PreserveAspectCrop
        cache: true
        smooth: true
        z: -1
        visible: source !== ""
        opacity: 1.0
    }

    Timer {
        id: wallpaperWatcher
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var xhr = new XMLHttpRequest();
            var tsPath = "file://" + (Directories.config === undefined ? "" : (Directories.config + "/quickshell/current_wallpaper_ts"));
            try {
                xhr.open("GET", tsPath);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 0 || (xhr.status >= 200 && xhr.status < 400)) {
                            var txt = xhr.responseText.trim();
                            if (txt !== wallpaperTimestamp) {
                                wallpaperTimestamp = txt;
                            }
                        }
                    }
                }
                xhr.send();
            } catch (e) {
                // ignore errors (file may not exist yet)
            }
        }
    }

    // Force initialization of some singletons
    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme()
        ConfigLoader.loadConfig()
    }

    Loader { active: enableOverview; sourceComponent: Overview {} }

}
