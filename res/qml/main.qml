import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12  as QQC2
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

import Common 1.0
import Theme 1.0
import MParticles 1.0
import Pages 1.0

///TODO текст как в матрице фоном https://thecode.media/cloudly/

QQC2.ApplicationWindow {
    id:appWnd
    // ----- Property Declarations
    property bool isMoreMenuNeed: true

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation
    readonly property bool appInForeground:  Qt.application.state === Qt.ApplicationActive
    property bool appInitialized:          false
    // ----- Signal declarations
    signal screenOrientationUpdated(int screenOrientation)



    // ----- Size information
    width:  320 * DevicePixelRatio
    height: 480 * DevicePixelRatio
    // ----- Then comes the other properties. There's no predefined order to these.
    visible: true
    visibility:  (isMobile) ? Window.FullScreen : Window.Windowed
    flags: Qt.Dialog
    title:  qsTr(" ")
    Screen.orientationUpdateMask: Qt.PortraitOrientation  |
                                  Qt.LandscapeOrientation |
                                  Qt.InvertedPortraitOrientation |
                                  Qt.InvertedLandscapeOrientation
    Material.theme: Theme.theme
    Material.primary: Theme.primary
    Material.accent:  Theme.accent
    Material.background: Theme.background
    Material.foreground: Theme.foreground

    // ----- Then attached properties and attached signal handlers.

    // ----- States and transitions.
    // ----- Signal handlers
    onScreenOrientationChanged: {
        screenOrientationUpdated(screenOrientation);
    }

    onAppInForegroundChanged: {
        if (appInForeground ) {
            if (!appInitialized) {
                appInitialized = true;
                Theme.setDarkMode()
            }
        } else {
            if (isDebugMode)
                console.log("onAppInForegroundChanged-> [appInForeground:"+appInForeground+", appInitialized:"+appInitialized+"]")
        }
    }
    // ----- Visual children

    header: QQC2.ToolBar{
        RowLayout{
            anchors.fill: parent
            spacing: 2 * DevicePixelRatio
            QQC2.ToolButton{
                id: btnDrawer
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                icon.source:  "qrc:/res/images/icons/ic_drawer.svg"

                onClicked: {
                    if(!navDrawer.opened)
                        navDrawer.open()

                    if(navDrawer.opened)
                        navDrawer.close()
                }
            }

            Item {
                // spacer item
                Layout.fillHeight: true
            }

            EasterEggLabel {
                id:toolBarPageTitle
                Layout.fillWidth: true
                text: swipeView.currentItem.title
                font {
                    family: font_families
                    pointSize: 18
                }
            }

            Item {
                // spacer item
                Layout.fillHeight: true
            }

            QQC2.ToolButton{
                id: btnMoreMenu
                visible: isMoreMenuNeed
                icon.source: "qrc:/res/images/icons/ic_bullet.svg"
                action: optionsMenuAction
            }
        }
    }

    HDrawer {
        id: navDrawer

        iconTitle: Qt.application.name
        iconSource: "qrc:/res/images/logo.svg"
        iconSubtitle: qsTr ("Version "+Qt.application.version)
        highlighted: true
        highlightedColor:Theme.primary
        bgColor:Theme.background
        primaryColor:Theme.primary
        foregroundColor:Theme.foreground
        isDarkMode:Theme.isDarkMode()
        // Define the drawer items
        /// TODO extract list model to other file
        items: ListModel {
            id: pagesModel

            ListElement {
                pageTitle: qsTr ("Summary")
                pageIcon: "qrc:/res/images/icons/ic_hardware.png"
                pageIndex:PageEnums.Index.Summary
            }

            ListElement {
                pageTitle: qsTr ("Uptime")
                pageIcon: "qrc:/res/images/icons/ic_uptime.png"
                pageIndex:PageEnums.Index.Uptime
            }

            ListElement {
                pageTitle: qsTr ("Memory")
                pageIcon: "qrc:/res/images/icons/ic_ram.png"
                pageIndex:PageEnums.Index.Memory
            }

            ListElement {
                pageTitle: qsTr ("Soc")
                pageIcon: "qrc:/res/images/icons/ic_cpu.png"
                pageIndex:PageEnums.Index.Soc
            }

            ListElement {
                pageTitle: qsTr ("Battery")
                pageIcon: "qrc:/res/images/icons/ic_battery.png"
                pageIndex:PageEnums.Index.Battery
            }

            ListElement {
                pageTitle: qsTr ("Process")
                pageIcon: "qrc:/res/images/icons/ic_hardware.png"
                pageIndex:PageEnums.Index.Process
            }

            ListElement {
                pageTitle: qsTr ("Storage")
                pageIcon: "qrc:/res/images/icons/id_sd-card.png"
                pageIndex:PageEnums.Index.Storage
            }

            ListElement {
                spacer: true
            }

            ListElement {
                separator: true
            }

            ListElement {
                pageTitle: qsTr ("Help")
                pageIcon: "qrc:/res/images/icons/ic_help.png"
                pageIndex:PageEnums.Index.Help
            }

            ListElement {
                pageTitle: qsTr ("About")
                pageIcon: "qrc:/res/images/icons/ic_info.png"
                pageIndex:PageEnums.Index.About
            }

        }
        onClickListItem: function(itemIndex) {
            if (isDebugMode)
                console.log ("onClickListItem:"+itemIndex)
            gotoPage( itemIndex )
            navDrawer.close()
        }

    }

    QQC2.SwipeView {
        id: swipeView
        anchors.fill: parent

        Summary {
            id:summaryPage
            title:  qsTr("Summary")
        }

        About {
            id:uptimePage
            title:  qsTr("Uptime")
        }
        About {
            id:memoryPage
            title:  qsTr("Memory")
        }
        Soc {
            id:socPage
            title:  qsTr("Soc")
        }
    }

    QQC2.PageIndicator {
        id:pageIndicator
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        currentIndex: swipeView.currentIndex
        count: swipeView.count

        delegate: Rectangle {
            implicitWidth: 8 *  DevicePixelRatio
            implicitHeight: 8 * DevicePixelRatio

            radius: (width / 2) * DevicePixelRatio
            color: Theme.accent

            opacity: index === pageIndicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

            Behavior on opacity {
                OpacityAnimator {
                    duration: 100
                }
            }
        }
    }

    Toast{
        id:mainToast
        z:100
        bgColor:Theme.primary
        Material.elevation: 8
    }

    Explosion{
        id:explosion
    }

    Smoke{
        id:smoke
    }

    // ----- Qt provided non-visual children

    Connections {
        target: toolBarPageTitle
        function onShowEasterEgg(msg) {
            mainToast.show(msg)
            explosion.explode()
            smoke.explode()
        }
    }

    Connections {
        target: summaryPage
        function onSwipeToPage(pageIndex) {
            gotoPage( pageIndex )
            if (isDebugMode)
                console.log ("onSwipeToPage:"+pageIndex)
        }
    }

    QQC2.Action {
        id: optionsMenuAction
        icon.name: "menu"
        onTriggered: {
            Theme.toggleTheme()
            //   optionsMenu.open()
        }
    }

    QQC2.Action {
        id: settingsMenuAction
        text: qsTr("&Settings ...")
        onTriggered: {
            if (isDebugMode)
                console.log("settings menu")
        }
    }

    QQC2.Action {
        id: helpMenuAction
        text:  qsTr("&Help")
        icon.name: "help"
        onTriggered:  {
            if (isDebugMode)
                console.log("help menu")
        }
    }

    QQC2.Action {
        id: aboutMenuAction
        text: qsTr("About")
        icon.name: "about"
        onTriggered:  {
            swipeView.setCurrentIndex(1)

            if (isDebugMode)
                console.log("About")
        }
    }

    QQC2.Action {
        id: memoryUsageAction
        text:  qsTr("&Memory usage...")
        icon.name: "about"
        onTriggered:  {

            if (isDebugMode)
                console.log("Memory usage click")
        }
    }

    QQC2.Action {
        id: cpuUsageAction
        text:  qsTr("&CPUs usage...")
        icon.name: "about"
        onTriggered:  {

            if (isDebugMode)
                console.log("CPUs usage click")
        }
    }

    QQC2.Action {
        id: storageUsageAction
        text:  qsTr("&Storage usage...")
        icon.name: "about"
        onTriggered:  {

            if (isDebugMode)
                console.log("Storage usage click")
        }
    }

    QQC2.Action {
        id: batteryInfoAction
        text:  qsTr("&Battery info...")
        icon.name: "about"
        onTriggered:  {
            if (isDebugMode)
                console.log("Battery Info click")
        }
    }

    QQC2.Action {
        id: processesInfoAction
        text:  qsTr("&Processes info...")
        icon.name: "about"
        onTriggered:  {
            if (isDebugMode)
                console.log("Processes click")
        }
    }
    // ----- Custom non-visual children

    // ----- JavaScript functions

    function toggleMoreMenuVisible(){
        isMoreMenuNeed = !isMoreMenuNeed
        if (isDebugMode)
            console.log ("isMoreMenuNeed:"+isMoreMenuNeed)
    }

    function gotoPage(pageIndex){
        console.log("swipeView.count:"+swipeView.count)
        if(pageIndex === swipeView.currentIndex) {
            // it's the current page
            return
        }

        if(pageIndex > swipeView.count || pageIndex < 0) {
            return
        }
        swipeView.setCurrentIndex( pageIndex )
    }
}

