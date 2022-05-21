pragma Singleton
import QtQuick 2.12
import QtQuick.Controls.Material 2.12

Item{
    id: control

    property int theme:      Material.theme

    readonly property color primaryColor:    theme  ? "#3e4559": Material.color(Material.Orange)
    readonly property color accentColor:     theme  ? "#26a69a": Material.color(Material.DeepOrange)
    readonly property color backgroundColor: theme  ? "#2d3140": "#fff4e5"
    readonly property color foregroundColor: theme  ? "#3e4559": Material.color(Material.Orange)

    function toggleTheme(){
        control.theme = (control.theme === 1 ? 0 : 1)
    }

    function isDarkMode(){
        return control.theme === Material.Dark
    }
}
