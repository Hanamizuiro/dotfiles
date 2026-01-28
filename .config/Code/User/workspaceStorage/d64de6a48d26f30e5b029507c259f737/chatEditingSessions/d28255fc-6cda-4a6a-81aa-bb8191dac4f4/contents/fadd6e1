import QtQuick
import qs.Common
import qs.Services
import qs.Modules.ControlCenter.BuiltinPlugins
import "../../../../modules/dank/ControlCenter/utils/widgets.js" as WidgetUtils

QtObject {
    id: root

    property var vpnBuiltinInstance: null
    property var cupsBuiltinInstance: null

    // Keep a minimal adapter to the original WidgetUtils functions by delegating
    function getWidgetForId(widgetId) {
        return WidgetUtils.getWidgetForId([], widgetId)
    }

    readonly property var baseWidgetDefinitions: []

    function getPluginWidgets() { return [] }
    function addWidget(widgetId) {}
    function removeWidget(index) {}
    function toggleWidgetSize(index) {}
    function moveWidget(fromIndex, toIndex) {}
    function resetToDefault() {}
    function clearAll() {}
}
