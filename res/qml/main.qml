import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12  as QQC2
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12

import "common"
import "Pages"

///TODO текст как в матрице фоном https://thecode.media/cloudly/

QQC2.ApplicationWindow {
    id:appWnd
    // ----- Property Declarations
    property bool isMoreMenuNeed: false

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation

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
    // ----- Then attached properties and attached signal handlers.
    // ----- States and transitions.
    // ----- Signal handlers
    onScreenOrientationChanged: {
        screenOrientationUpdated(screenOrientation);
    }

    //    ///TODO move to qquickcontrols.2
    Material.theme: Material.Dark
    //Material.primary: "#1de9b6"
    //Material.accent: "#3d5afe"

    // ----- Visual children
    header: QQC2.ToolBar{
        //Material.background: Material.Teal
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

            QQC2.Label {
                id:toolBarPageTitle
                text: "Title"
                elide: QQC2.Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                color:Material.primaryColor
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
        highlighted: false
        //
        // Define the actions to take for each drawer item
        // Drawers 7 and 8 are ignored, because they are used for
        // displaying a spacer and a separator
        //
        actions: {
            0: function() { gotoPage(0) },
            1: function() { gotoPage(1) },
            2: function() { gotoPage(2) },
            3: function() { gotoPage(3) },
            4: function() { gotoPage(4) },
            5: function() { gotoPage(5) },
            6: function() { gotoPage(6) },
            9: function() { gotoPage(9) },
            10: function() { gotoPage(10) }
        }

        //
        // Define the drawer items
        //
        items: ListModel {
            id: pagesModel

            ListElement {
                pageTitle: qsTr ("Summary")
                pageIcon: "qrc:/res/images/icons/ic_hardware.png"
            }

            ListElement {
                pageTitle: qsTr ("Uptime")
                pageIcon: "qrc:/res/images/icons/ic_uptime.png"
            }

            ListElement {
                pageTitle: qsTr ("Memory")
                pageIcon: "qrc:/res/images/icons/ic_ram.png"
            }

            ListElement {
                pageTitle: qsTr ("CPUs")
                pageIcon: "qrc:/res/images/icons/ic_cpu.png"
            }

            ListElement {
                pageTitle: qsTr ("Battery")
                pageIcon: "qrc:/res/images/icons/ic_battery.png"
            }

            ListElement {
                pageTitle: qsTr ("Process")
                pageIcon: "qrc:/res/images/icons/ic_hardware.png"
            }

            ListElement {
                pageTitle: qsTr ("Storage")
                pageIcon: "qrc:/res/images/icons/id_sd-card.png"
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
            }

            ListElement {
                pageTitle: qsTr ("Info")
                pageIcon: "qrc:/res/images/icons/ic_info.png"
            }
        }
    }

    QQC2.SwipeView {
        id: swipeView
        anchors.fill: parent
        background: Image {
            source: "qrc:/res/images/cover.jpg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            opacity: 0.8
        }

        Summary {
            id:summaryPage
        }

        About {
            id:aboutPage

        }

        onCurrentIndexChanged: {
            toolBarPageTitle.text = swipeView.currentItem.title
        }
    }

    QQC2.PageIndicator {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        currentIndex: swipeView.currentIndex
        count: swipeView.count
    }

    // ----- Qt provided non-visual children

    QQC2.Action {
        id: optionsMenuAction
        icon.name: "menu"
        onTriggered: optionsMenu.open()
    }

    QQC2.Action {
        id: settingsMenuAction
        text: qsTr("&Settings ...")
        onTriggered: {
            console.log("settings menu")
        }
    }

    QQC2.Action {
        id: helpMenuAction
        text:  qsTr("&Help")
        icon.name: "help"
        onTriggered:  {
            console.log("help menu")
        }
    }

    QQC2.Action {
        id: aboutMenuAction
        text: qsTr("About")
        icon.name: "about"
        onTriggered:  {
            swipeView.setCurrentIndex(1)
            //mainStackView.push(Qt.resolvedUrl("qrc:/res/qml/Pages/About.qml"))
            console.log("About")
        }


    }

    QQC2.Action {
        id: memoryUsageAction
        text:  qsTr("&Memory usage...")
        icon.name: "about"
        onTriggered:  {
            //mainStackView.push(Qt.resolvedUrl("qrc:/res/qml/Pages/Memory.qml"))
            console.log("Memory usage click")
        }

    }
    QQC2.Action {
        id: cpuUsageAction
        text:  qsTr("&CPUs usage...")
        icon.name: "about"
        onTriggered:  {
            //mainStackView.push(Qt.resolvedUrl("qrc:/res/qml/Pages/Memory.qml"))
            console.log("CPUs usage click")
        }
    }

    QQC2.Action {
        id: storageUsageAction
        text:  qsTr("&Storage usage...")
        icon.name: "about"
        onTriggered:  {
            //mainStackView.push(Qt.resolvedUrl("qrc:/res/qml/Pages/Memory.qml"))
            console.log("Storage usage click")
        }
    }

    QQC2.Action {
        id: batteryInfoAction
        text:  qsTr("&Battery info...")
        icon.name: "about"
        onTriggered:  {
            //mainStackView.push(Qt.resolvedUrl("qrc:/res/qml/Pages/Memory.qml"))
            console.log("Battery Info click")
        }
    }

    QQC2.Action {
        id: processesInfoAction
        text:  qsTr("&Processes info...")
        icon.name: "about"
        onTriggered:  {
            //mainStackView.push(Qt.resolvedUrl("qrc:/res/qml/Pages/Memory.qml"))
            console.log("Processes click")
        }
    }
    // ----- Custom non-visual children

    // ----- JavaScript functions

    function toggleMoreMenuVisible(){
        isMoreMenuNeed = !isMoreMenuNeed
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

