import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

import Common 1.0
import Theme 1.0
import Test  1.0

QQC2.Page {
    id:control
    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool pageActive:  QQC2.SwipeView.isCurrentItem

    property bool pageInitialized: false
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onPageActiveChanged: {
        if ( pageActive) {
            if (!pageInitialized) {
                pageInitialized = true;
                pageAnimation.start()
            }
        }
    }
    Component.onCompleted: {
        console.log("UpTime page completed")
    }

    // ----- Visual children.
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
                                text: "getSocName()"

                                font {
                                    pointSize: 16
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
                }
            }
        }
        ProportionalRect {
            id:bodyRectangle
            Layout.preferredHeight: 380 * DevicePixelRatio
            QQC2.Pane{
                /// TODO need extract to file
                id:bodyPanel
                property bool flat: enabled && Material.elevation > 0
                property int radius: 4 * DevicePixelRatio
                anchors.fill: parent
                Material.elevation: 4 * DevicePixelRatio

                background: Rectangle {
                    border.color: bodyPanel.flat ? Qt.rgba(0,0,0,0.2) : "transparent"
                    color: Theme.primary
                    radius:  bodyPanel.Material.elevation > 0 ? bodyPanel.radius : 0
                    layer.enabled: bodyPanel.flat
                    layer.effect: ElevationEffect {
                        elevation: bodyPanel.Material.elevation
                    }
                }
                QQC2.Label{
                     anchors.fill: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight

                    font { family: font_families }
                    text:"TEST"
                }
            }
        }
    }

    Item{
        id:firstRunParent
        anchors.fill: parent
        Image {
            id:logoImage

            anchors.fill: parent

            smooth: true
            opacity: 0
            fillMode: Image.PreserveAspectFit
            source: "qrc:/res/images/icons/ic_uptime.png"
            state: pageInitialized ? "OLD_PLACE" :"NEW_PLACE"
            states: [
                State {
                    name: "NEW_PLACE"
                    ParentChange {
                        target: logoImage
                        parent: imageItemFinishPlace
                    }
                    PropertyChanges {
                        target: logoImage
                        opacity: Theme.isDarkMode() ? 0.54 : 1.0
                    }
                },
                State {
                    name: "OLD_PLACE"
                    ParentChange {
                        target: logoImage
                        parent: firstRunParent
                    }
                }
            ]
        }
    }

    background:{null}
    // ----- Qt provided non-visual children
    SequentialAnimation {
        id:pageAnimation
        running: false
    }
}
