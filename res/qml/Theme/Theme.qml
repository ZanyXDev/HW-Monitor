pragma Singleton

import QtQuick 2.12
import QtQuick.Controls.Material 2.12

//https://material-theme.com/docs/reference/color-palette/
Item{
    id: control

    property int theme:      Material.Dark

    property var primary:    Material.primary
    property var accent:     Material.accent
    property var background: Material.background
    property var foreground: Material.foreground

    function toggleTheme(){
        control.theme = (control.theme === Material.Dark ? Material.Light : Material.Dark)
        control.primary    =   (control.theme === Material.Dark) ? "#003946": "#d1cbb8"
        control.accent     =   (control.theme === Material.Dark) ? "#d13684": "#d33682"
        control.background =   (control.theme === Material.Dark) ? "#002B36": "#fdf6e3"
        control.foreground =   (control.theme === Material.Dark) ? "#839496": "#586e75"
    }

    function isDarkMode(){
        return control.theme === Material.Dark
    }

    function setDarkMode(){
        control.theme = Material.Dark
        toggleTheme()
    }
}
