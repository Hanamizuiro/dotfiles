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
import "./modules/dms_controlcenter/ControlCenter"

ShellRoot {
    // Enable/disable modules here. False = not loaded at all, so rest assured
    // no unnecessary stuff will take up memory if you decide to only use, say, the overview.
    property bool enableOverview: true

    // Background wallpaper (bound to Appearance.background_image)
    Image {
        id: quickshellWallpaper
        anchors.fill: parent
        // Ensure absolute paths are prefixed with file:// for QML Image
        property string bgSource: Appearance.background_image === undefined || Appearance.background_image === null || Appearance.background_image === "" ? "" : (Appearance.background_image.indexOf("file://") === 0 ? Appearance.background_image : "file://" + Appearance.background_image)
        source: bgSource
        fillMode: Image.PreserveAspectCrop
        cache: true
        smooth: true
        z: -1
        visible: source !== ""
        opacity: 1.0
    }

    // Force initialization of some singletons
    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme()
        ConfigLoader.loadConfig()
    }

    Loader { active: enableOverview; sourceComponent: Overview {} }

    // DMS Control Center (namespaced copy via modules/dms_controlcenter)
    // This loader is inactive by default; set dmsControlCenterLoader.active = true to show it.
    Loader {
        id: dmsControlCenterLoader
        active: false
        asynchronous: true
        sourceComponent: ControlCenterPopout {}
        onLoaded: {
            // If a PopoutService exists, try to register the popout so other parts of the UI can toggle it
            try {
                if (PopoutService !== undefined) {
                    PopoutService.controlCenterPopout = item
                }
            } catch (e) { console.warn('PopoutService not available:', e) }
        }
    }

}
