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
        spacing: 2 * DevicePixelRatio
        anchors.margins: 0
        anchors.fill: parent

        visible:false

        ListView {
            id: socListView
            ///TODO separate model to cpp part
            model: ListModel {
                id: socModel

                ListElement {

                    socItemName: qsTr ("Snapdragon")
                    socItemText: qsTr ("888")
                    socItemDesc: qsTr ("888")
                }
                ListElement {

                    socItemName: qsTr ("testName")
                    socItemText: qsTr ("testText")
                    socItemDesc: qsTr ("testDesc")
                }
            }
            Layout.fillWidth: true
            Layout.fillHeight: true

            z: 0
            currentIndex: -1
            focus: true
            clip: true
            highlightFollowsCurrentItem: control.highlighted
            header: RowLayout{
                id:headerListViewRowLayout
                Item { Layout.preferredWidth: 8 * DevicePixelRatio  }
                Image {
                    id:headerImage
                    Layout.alignment:  Qt.AlignHCenter | Qt.AlignVCenter
                    smooth: true
                    //opacity: isDark ? 0.54 : 1.0
                    fillMode: Image.Pad
                    source: "qrc:/res/images/icons/ic_hardware.png"
                    sourceSize: Qt.size (72, 72)
                }
                Item { Layout.preferredWidth: 8 * DevicePixelRatio  }
                QQC2.Label {
                    id:headerLabel
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true

                    text: qsTr ("Snapdragon")
                    font {
                        family: font_families
                        pointSize: 14
                        weight: Font.Medium
                    }
                }
                Item { Layout.preferredWidth: 8 * DevicePixelRatio  }
            }
            delegate:
                Rectangle{

                implicitHeight:32 * DevicePixelRatio
                width: parent.width
                color:"green"
            }

        }
    }
    // ----- Qt provided non-visual children


    // ----- Custom non-visual children

    // ----- JavaScript functions
}

