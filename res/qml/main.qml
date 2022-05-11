import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12  as QQC2
import QtQuick.LocalStorage 2.12

import "Pages"


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
    Component.onCompleted: {

        var component = Qt.createComponent("qrc:/res/qml/Pages/Summary.qml");

        if (component.status === Component.Ready) {
            mainStackView.push(component);
        } else {
            console.error(component.errorString());
        }
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
                text: qsTr("Hardware monitor")
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
                        id: menuHelpItem
                        action:helpMenuAction
                    }
                    QQC2.MenuSeparator { }
                    QQC2.MenuItem {
                        id: menuAboutItem
                        action:aboutMenuAction
                    }
                }
            }
        }
    }

    Image{
        id:bgImage
        z: -1
        source: "qrc:/res/images/cover.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.8
    }

    QQC2.StackView {
        id:           mainStackView
        anchors.fill: parent
        focus: true

        MultiPointTouchArea {
            anchors.fill: parent
            z:            1
            enabled:      mainStackView.busy
        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "scale"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "scale"
                from: 1
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "scale"
                from: 0
                to:1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "scale"
                from: 1
                to:0
                duration: 200
            }
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                pageBack(event)
                console.log("Qt.Key_Back Released")
            }
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Escape){
                pageBack(event)
                console.log("Qt.Key_Escape pressed")
            }
        }

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
        text:  qsTr("&About")
        icon.name: "about"
        onTriggered:  {
            mainStackView.push(Qt.resolvedUrl("About.qml"))
            console.log("About")
        }
    }
    // ----- Custom non-visual children


    // ----- JavaScript functions
    // Обработка нажатия кнопки выхода с текущей страницы
    function pageBack(event) {
        console.log("pageBack(event)->mainStackView.dept:"+mainStackView.depth)
        if( mainStackView.depth > 1 ) {

            mainStackView.pop()
            event.accepted = true
        }
    }
}

