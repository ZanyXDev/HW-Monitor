import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Particles 2.15
import QtQuick.Shapes 1.0

import Common 1.0
import Theme 1.0
import Test  1.0

QQC2.Page {
    id:control

    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool pageActive:  QQC2.SwipeView.isCurrentItem
    property bool highlighted: false
    property bool pageInitialized: false
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onPageActiveChanged: {
        if ( pageActive) {
            if (!pageInitialized) {
                pageInitialized = true;
                socImageAnimation.start()
            }
        }
    }
    Component.onCompleted: {
        console.log("Soc page completed")
    }

    // ----- Visual children.
    background:{null}


    ColumnLayout {
        visible: true
        id: mainPageLayout

        spacing: 2 * DevicePixelRatio
        anchors{
            topMargin: 4  * DevicePixelRatio
            leftMargin: 4  * DevicePixelRatio
            rightMargin: 4  * DevicePixelRatio
            bottomMargin: 16  * DevicePixelRatio
            fill: parent
        }

        component ProportionalRect: Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            Layout.preferredHeight: 1
        }

        ProportionalRect {
            id:headerTopRow
            Layout.preferredHeight: 92 * DevicePixelRatio
            MaterialPane{
                id:headerPanel
                primaryColor:Theme.primary

                RowLayout {
                    id:headerRowLayout
                    anchors.fill: parent
                    spacing: 8 * DevicePixelRatio
                    Item{
                        id:imageItemFinishPlace
                        objectName: "imageItemFinishPlace"
                        Layout.preferredWidth: 72 * DevicePixelRatio
                        Layout.preferredHeight: 72 * DevicePixelRatio
                    }
                    Item{
                        id:socDescribeItem
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        ColumnLayout{
                            id:headerTextColumnLayout
                            anchors.fill: socDescribeItem
                            spacing: 8 * DevicePixelRatio
                            component InfoLabel: QQC2.Label{
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                                Layout.fillWidth : true
                                Layout.fillHeight: true

                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                                font { family: font_families }
                            }
                            InfoLabel{
                                id:socNameText
                                text: getSocName()

                                font {
                                    pointSize: 16
                                    weight: Font.Medium
                                }
                            }
                            InfoLabel{
                                ///TODO need extract to component Label with link
                                id:socURLText

                                visible: (text.length > 0) ? true: false
                                ///TODO need write
                                text: "To view more about Soc, <a href='https://www.back4app.com/database/paul-datasets'>click here</a>"
                                font {
                                    pointSize: 12
                                }
                                // Since Text (and Label) lack cursor-changing abilities of their own,
                                // as suggested by QTBUG-30804, use a MouseAra to do our dirty work.
                                // See comment https://bugreports.qt.io/browse/QTBUG-30804?#comment-206287
                                // TODO: Once HoverHandler and friends are able to change cursor shapes, this will want changing to that method
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
                                    cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                                }
                            }
                        }
                    }
                    //Item { Layout.preferredWidth:   8 * DevicePixelRatio  }
                }
            }
        }

        ProportionalRect {
            id:bodyListView
            Layout.preferredHeight: 380 * DevicePixelRatio
            MaterialPane{
                id:listViewPanel
                primaryColor:Theme.primary

                ListView {
                    id:socListView
                    anchors.fill: parent

                    focus: true
                    clip: true
                    z: 0
                    currentIndex: -1
                    model: socModel
                    spacing: 2 * DevicePixelRatio
                    highlightFollowsCurrentItem: true
                    highlight: Component{

                        Rectangle {
                            z:2
                            color: Theme.accent
                            radius: listViewPanel.radius

                            opacity: 0.72
                            y: socListView.currentItem.y

                            Behavior on y {
                                SpringAnimation {
                                    spring: 3
                                    damping: 0.2
                                }
                            }
                        }
                    }
                    delegate: LWDelegate {
                        primaryColor: Theme.background
                        width: socListView.width
                        implicitHeight: 24 * DevicePixelRatio
                        isCurrent:  ListView.isCurrentItem
                        keyText:model.key
                        valueText:model.value
                        onClicked: {
                            socListView.currentIndex = index
                        }
                    }
                    QQC2.ScrollBar.vertical: QQC2.ScrollBar {
                        policy: socListView.contentHeight > socListView.height ?
                                    QQC2.ScrollBar.AlwaysOn : QQC2.ScrollBar.AlwaysOff
                    }
                    keyNavigationEnabled: false // Disable key up and key down
                    Component.onCompleted: currentIndex = 0
                }
            }
        }

    }

    Item{
        id:firstRunParent
        anchors.fill: parent
        Image {
            id:socImage
            objectName: "test"
            anchors.fill: parent

            smooth: true
            opacity: 0
            fillMode: Image.PreserveAspectFit
            source: "qrc:/res/images/soc.png"
            state: pageInitialized ? "OLD_PLACE" :"NEW_PLACE"
            states: [
                State {
                    name: "NEW_PLACE"
                    ParentChange {
                        target: socImage
                        parent: imageItemFinishPlace
                    }
                    PropertyChanges {
                        target: socImage
                        opacity: Theme.isDarkMode() ? 0.54 : 1.0
                    }
                },
                State {
                    name: "OLD_PLACE"
                    ParentChange {
                        target: socImage
                        parent: firstRunParent
                    }
                }
            ]
        }
    }


    // ----- Qt provided non-visual children
    SequentialAnimation {
        id:socImageAnimation
        running: false

        ScaleAnimator {
            target: headerPanel
            from: 0
            to: 1
            duration: 500
            easing.type: Easing.OutQuad
        }

        NumberAnimation {
            target: socImage;
            properties: 'opacity';
            from: 0;
            to: 1;
            duration: 1000;
            easing.type: Easing.OutQuad;
        }

        NumberAnimation {
            target: socImage;
            properties: 'opacity';
            from: 1;
            to: 0;
            duration: 500;
            easing.type: Easing.OutQuad;
        }

        onFinished: {
            socImage.state = "NEW_PLACE"
            // smoke.explode()
        }
    }

    // ----- Custom non-visual children
    SocModel {
        id:socModel
    }
    // ----- JavaScript functions
    function getSocName(){
        if (isDebugMode){
            console.log("socModel.count:",socModel.count)
        }
        return (socModel.count > 0 ) ? socModel.get(0).value : "[Undefined]"
    }
}

