import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Particles 2.15

import Common 1.0
import Theme 1.0

QQC2.Page {
    id:control

    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool pageActive:  QQC2.SwipeView.isCurrentItem
    property bool highlighted: false
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.

    Component.onCompleted: {
        console.log("Soc page completed")
    }

    // ----- Visual children.
    background:{null}


    ColumnLayout {
        id: mainPageLayout
        spacing: 4 * DevicePixelRatio
        anchors{
            margins: 4  * DevicePixelRatio
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
                Material.elevation:  2 * DevicePixelRatio

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
                    id:normalLayout
                    anchors.fill: parent
                    spacing: 8 * DevicePixelRatio
                    Item{
                        id:imageItemFinishPlace
                        objectName: "imageItemFinishPlace"
                        Layout.preferredWidth: 72 * DevicePixelRatio
                        Layout.preferredHeight: 72 * DevicePixelRatio
                    }
                }
            }
        }
        ProportionalRect {
            id:bodyListView
            Layout.preferredHeight: 380 * DevicePixelRatio
            Rectangle{
                anchors.fill: parent
                color: "green"
            }
        }

        //            RowLayout {
        //                id:normalLayout
        //                Layout.fillWidth: true
        //                Layout.fillHeight: true

        //                spacing: 8 * DevicePixelRatio

        //                Item { Layout.preferredWidth:   8 * DevicePixelRatio  }
        //                Item {
        //                    id:imageItemFinishPlace
        //                    Layout.preferredWidth:   72 * DevicePixelRatio
        //                    Layout.preferredHeight:  72 * DevicePixelRatio
        //                    Layout.alignment:  Qt.AlignHCenter | Qt.AlignVCenter
        //                }
        //                Item { Layout.fillWidth: true }
        //            }
        //        ListView {
        //            id: socListView

        //            ///TODO separate model to cpp part
        //            model: ListModel {
        //                id: socModel

        //                ListElement {

        //                    socItemName: qsTr ("Snapdragon")
        //                    socItemText: qsTr ("888")
        //                    socItemDesc: qsTr ("888")
        //                }
        //                ListElement {

        //                    socItemName: qsTr ("testName")
        //                    socItemText: qsTr ("testText")
        //                    socItemDesc: qsTr ("testDesc")
        //                }
        //            }
        //            Layout.fillWidth: true
        //            Layout.fillHeight: true

        //            z: 0
        //            currentIndex: -1
        //            focus: true
        //            clip: true
        //            highlightFollowsCurrentItem: control.highlighted

        //            delegate:
        //                Rectangle{
        //                implicitHeight:32 * DevicePixelRatio
        //                width: parent.width
        //                color:"green"
        //            }

        //        }

    }

    Image {
        id:socImage
        objectName: "test"
        //  z: 2
        anchors{
            top:parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        smooth: true
        opacity: Theme.isDarkMode() ? 0.54 : 1.0
        fillMode: Image.PreserveAspectFit
        source: "qrc:/res/images/soc.png"



        states: State {
            name: "reparented"
            ParentChange {
                target: socImage
                parent: imageItemFinishPlace
            }

        }


        onPaintedGeometryChanged:  {
            if (isDebugMode){
                console.log("onPaintedGeometryChanged", socImage.paintedHeight,socImage.paintedWidth)
                console.log("[x,y]",socImage.x,socImage.y)
            }
        }

        onParentChanged: {
            if (isDebugMode){
                console.log("Parent now is :", parent.objectName)
                console.log("Parent size :", parent.width,parent.height)
                console.log("socImage size :", socImage.width,socImage.height)
            }
        }
        MouseArea {
            anchors.fill: parent;
            onClicked: socImage.state = "reparented"
        }

    }

    // ----- Qt provided non-visual children


    // ----- Custom non-visual children

    // ----- JavaScript functions
}

