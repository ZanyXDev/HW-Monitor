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
            topMargin: 2  * DevicePixelRatio
            leftMargin: 2  * DevicePixelRatio
            rightMargin: 2  * DevicePixelRatio
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
            QQC2.Pane{
                /// TODO need extract to file
                id:headerPanel
                property bool flat: enabled && Material.elevation > 0
                property int radius: 4 * DevicePixelRatio
                anchors.fill: parent
                Material.elevation:  4 * DevicePixelRatio

                background: Rectangle {
                    border.color: headerPanel.flat ? Qt.rgba(0,0,0,0.2) : "transparent"
                    color: Theme.primary
                    radius:  headerPanel.Material.elevation > 0 ? headerPanel.radius : 0
                    layer.enabled: headerPanel.flat
                    layer.effect: ElevationEffect {
                        elevation: headerPanel.Material.elevation
                    }
                }
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
                                text:"SoC name"

                                font {
                                    pointSize: 24
                                    weight: Font.Medium
                                }
                            }
                            InfoLabel{
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
            QQC2.Pane{
                /// TODO need extract to file
                id:listViewPanel
                property bool flat: enabled && Material.elevation > 0
                property int radius: 4 * DevicePixelRatio
                anchors.fill: parent
                Material.elevation: 4 * DevicePixelRatio

                background: Rectangle {
                    border.color: headerPanel.flat ? Qt.rgba(0,0,0,0.2) : "transparent"
                    color: Theme.primary
                    radius:  headerPanel.Material.elevation > 0 ? headerPanel.radius : 0
                    layer.enabled: headerPanel.flat
                    layer.effect: ElevationEffect {
                        elevation: headerPanel.Material.elevation
                    }
                }

                ListView {
                    id:socListView
                    anchors.fill: parent

                    focus: true
                    clip: true

                    model:  SocModel {}
                    spacing: 2 * DevicePixelRatio
                    delegate: LWDelegate {
                        width: socListView.width
                        implicitHeight: 24 * DevicePixelRatio
                        isCurrent:  ListView.isCurrentItem
                        keyText:model.key
                        valueText:model.value
                        onClicked: {
                            socListView.currentIndex = index
                            console.log("socListView.currentIndex:",index)
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
            smoke.explode()
        }
    }

    // ----- Custom non-visual children

    // ----- JavaScript functions
}

