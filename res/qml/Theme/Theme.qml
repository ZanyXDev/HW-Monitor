pragma Singleton
import QtQuick 2.12
import QtQuick.Controls.Material 2.12

Item{
    id: control

    property int theme:      Material.theme

    readonly property var primaryColor:    theme  ? Material.Orange: "#3e4559"
    readonly property var accentColor:     theme  ? Material.DeepOrange: "#26a69a"
    readonly property var backgroundColor: theme  ? "#fff4e5": "#2d3140"
    readonly property var foregroundColor: theme  ? Material.Orange: "#3e4559"

    function toggleTheme(){
        control.theme = (control.theme === 1 ? 0 : 1)
    }

    function isDarkMode(){
        return control.theme === Material.Dark
    }
}
