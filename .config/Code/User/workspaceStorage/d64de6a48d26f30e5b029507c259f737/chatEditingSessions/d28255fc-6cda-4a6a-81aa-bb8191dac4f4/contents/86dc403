pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "root:/modules/common/functions/file_utils.js" as FileUtils

/**
 * Watches the rofi current wallpaper symlink and triggers matugen
 * to generate a theme, then tells MaterialThemeLoader to reapply.
 *
 * This keeps theme generation inside QuickShell and avoids editing
 * hyprland configs or restarting services.
 */
Singleton {
    id: root

    // Path to the rofi current wallpaper symlink (without file://)
    readonly property string rofiSymlink: Qt.resolvedUrl(Directories.config) + "/rofi/.current_wallpaper"
    property string _lastResolved: ""
    property int pollIntervalMs: 1500
    property int matugenTimeoutMs: 20000

    Timer {
        id: pollTimer
        interval: root.pollIntervalMs
        repeat: true
        running: false
        onTriggered: {
            // Run readlink in a Process so we get the resolved path
            readlinkProc.start()
        }
    }

    Process {
        id: readlinkProc
        // use bash -lc so environment like $HOME expands reliably
        command: ["bash", "-lc", "readlink -f \"$HOME/.config/rofi/.current_wallpaper\" 2>/dev/null || true"]
        onFinished: {
            const out = stdout.trim()
            if (out === undefined || out === null) return;
            if (out.length === 0) return;
            if (out !== root._lastResolved) {
                root._lastResolved = out
                // Kick off matugen to generate theme for this wallpaper
                matugenProc.command = ["matugen", "image", out]
                matugenProc.start()
            }
        }
    }

    Process {
        id: matugenProc
        // we set command from JS to include the path
        onStarted: {
            // start a watchdog in case matugen hangs
            matugenWatch.start()
        }
        onFinished: {
            matugenWatch.stop()
            // After matugen completes, reapply the generated theme via MaterialThemeLoader
            // MaterialThemeLoader watches the generated theme file and will reload when it changes,
            // but calling reapplyTheme ensures immediate update if matugen wrote the file.
            MaterialThemeLoader.reapplyTheme()
        }
    }

    Timer {
        id: matugenWatch
        interval: root.matugenTimeoutMs
        repeat: false
        running: false
        onTriggered: {
            // matugen took too long; kill it
            try { matugenProc.kill() } catch (e) {}
            MaterialThemeLoader.reapplyTheme()
        }
    }

    Component.onCompleted: {
        // Start polling when the shell loads
        pollTimer.start()
    }

}
