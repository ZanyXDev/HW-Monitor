import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12  as QQC2
import QtQuick.LocalStorage 2.12

import "Pages"

///TODO текст как в матрице фоном https://thecode.media/cloudly/

QQC2.ApplicationWindow {
    id:appWnd
    // ----- Property Declarations

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation

    // ----- Signal declarations
    signal screenOrientationUpdated(int screenOrientation)

    // ----- Size information
    width:  320 * dp
    height: 480 * dp
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


    // ----- Visual children
    header: QQC2.ToolBar {
        RowLayout {
            anchors.fill: parent
            QQC2.ToolButton {
                text: qsTr("‹")
                font {
                    family: font_families;
                    pointSize:16
                }
                onClicked: pageBack()
            }
            QQC2.Label {
                id:pageTitle
                text: swipeView.currentItem ? swipeView.currentItem.title : qsTr("Hardware monitor")
                font {
                    family: font_families;
                    pointSize:16
                }
                elide: QQC2.Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            QQC2.ToolButton {
                text: qsTr("⋮")
                font {
                    family: font_families;
                    pointSize:18
                }

                action: optionsMenuAction

                QQC2.Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: QQC2.Menu.TopRight

                    QQC2.MenuItem {
                        id: menuSettingsItem
                        action:settingsMenuAction
                    }
                    QQC2.MenuItem {
                        id: menuMemoryItem
                        action:memoryUsageAction
                    }
                    QQC2.MenuItem {
                        id: menuCpuItem
                        action:cpuUsageAction
                    }
                    QQC2.MenuItem {
                        id: menuStorageUsageItem
                        action:storageUsageAction
                    }
                    QQC2.MenuItem {
                        id: menuBatteryItem
                        action:batteryInfoAction
                    }
                    QQC2.MenuItem {
                        id: menuProcessesItem
                        action:processesInfoAction
                    }
                    QQC2.MenuSeparator { }
                    QQC2.MenuItem {
                        id: menuHelpItem
                        action:helpMenuAction
                    }
                    QQC2.MenuItem {
                        id: menuAboutItem
                        action:aboutMenuAction
                    }
                }
            }
        }
    }

//    Image{
//        id:bgImage
//        z: -1
//        source: "qrc:/res/images/cover.jpg"
//        anchors.fill: parent
//        fillMode: Image.PreserveAspectCrop
//        opacity: 0.8
//    }

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
    // Обработка нажатия кнопки выхода с текущей страницы

}

