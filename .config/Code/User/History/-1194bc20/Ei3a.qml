pragma Singleton
pragma ComponentBehavior: Bound

import "root:/modules/common"
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * ThemeWatcher
 *
 * Simpler approach: watch the rofi .current_wallpaper entry with a FileView.
 * When the file changes, tell MaterialThemeLoader to reapply the generated
 * theme JSON. Wallpaper selection scripts already run matugen, so we only
 * need to prompt QuickShell to reload the JSON when the wallpaper pointer
 * is updated.
 */
Singleton {
    id: root

    // Path to the rofi current wallpaper symlink (file:// form expected by FileView)
    property string rofiFileUrl: Qt.resolvedUrl(Directories.config) + "/rofi/.current_wallpaper"

    FileView {
        id: rofiFileView
        path: root.rofiFileUrl
        watchChanges: true
        onFileChanged: {
            // When the symlink file is updated (WallpaperSelect.sh updates it atomically),
            // ask MaterialThemeLoader to reapply theme immediately. MaterialThemeLoader
            // itself watches the generated JSON file; this call forces an immediate reload
            // in case matugen already wrote the JSON.
            MaterialThemeLoader.reapplyTheme()
        }
        onLoadedChanged: {
            // Ensure we trigger a reload on initial load as singletons are lazily loaded.
            MaterialThemeLoader.reapplyTheme()
        }
    }

    Component.onCompleted: {
        // Force an initial load of the FileView so onLoadedChanged runs.
        rofiFileView.reload()
    }

}
