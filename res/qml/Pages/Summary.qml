import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0


import io.github.zanyxdev.qml_hwmonitor 1.0
import "../common"
import Theme 1.0

QQC2.Page {
    id:summaryPage

    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool pageActive:  QQC2.SwipeView.isCurrentItem
    property bool pageInitialized:          false
    title:  qsTr("Summary")
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.

    // ----- Then attached properties and attached signal handlers.
    // ----- States and transitions.
    // ----- Signal handlers

    onPageActiveChanged: {
        if ( pageActive) {
            if (!pageInitialized) {
                pageInitialized = true;
                ///TODO move to app activeChanged()
                Monitor.init();
            }
        } else {
            console.log("Page title:"+title+" pageAvtive ["+ pageActive+"]","pageInitialized ["+pageInitialized+"]")
        }
    }

    Component.onCompleted: {
        console.log("Summary page completed"," pageAvtive ["+ pageActive+"]")
    }
    // ----- Visual children.
    background:{ null }

    ColumnLayout{
        id:mainScreenLayout
        anchors.fill: parent
        spacing: 2 * DevicePixelRatio

        Item {
            // spacer item
            Layout.preferredHeight: 32 * DevicePixelRatio
            Layout.fillWidth: true
        }

        QQC2.Pane {
            id:control
            Layout.preferredHeight: 48 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            property int radius: 4 * DevicePixelRatio

            Material.elevation: 8
            background: Rectangle {
                border.color: "transparent"
                color:  Theme.primary

                radius: control.Material.elevation > 0 ? control.radius : 0

                layer.enabled: true
                layer.effect: ElevationEffect {
                    elevation: control.Material.elevation
                }
            }


            ColumnLayout {
                anchors.fill: parent
                spacing: 2 * DevicePixelRatio

                Item {
                    Layout.fillHeight:  true
                }

                QQC2.Label{
                    id: message

                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight

                    font {
                        family: font_families
                        pointSize: 18
                    }
                    text: qsTr("Uptime: " + Monitor.uptime)
                }
                Item{
                    Layout.preferredHeight: 4 * DevicePixelRatio
                    Layout.fillWidth:  true
                    //Layout.preferredWidth: parent.width - 140 * DevicePixelRatio
                    Layout.alignment: Qt.AlignTop | Qt.AlignCenter
                    layer.enabled: true
                    layer.samples: 4
                    DashLine{
                        anchors.fill: parent
                        stroke_width: 2 *  DevicePixelRatio
                        stroke_color: Theme.accent
                    }
                }

                Item {
                   Layout.fillHeight:  true
                }
            }

        }



        QQC2.Label{
            id:memoryUsageLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Memory usage: " + Monitor.memoryUsage + " %")
        }

        Item{
            Layout.preferredHeight: 4 * DevicePixelRatio
            Layout.preferredWidth: parent.width - 140 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DashLine{
                id:memoryDashLine
                anchors.fill: parent
                stroke_width: 2 *  DevicePixelRatio
                stroke_color: Theme.accent
            }
        }

        QQC2.Label{
            id:cpuLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("CPUs:" + Monitor.cpuUsage + " %")
        }

        Item{
            Layout.preferredHeight: 4 * DevicePixelRatio
            Layout.preferredWidth: parent.width - 140 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DashLine{
                id:cpuDashLine
                anchors.fill: parent
                stroke_width: 2 *  DevicePixelRatio
                stroke_color: Theme.accent
            }
        }

        QQC2.Label{
            id:batteryCapacityLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Battery capacity:" + Monitor.battareyCapacity + " %")
        }

        Item{
            Layout.preferredHeight: 4 * DevicePixelRatio
            Layout.preferredWidth: parent.width - 140 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DashLine{
                id:batteryDashLine
                anchors.fill: parent
                stroke_width: 2 *  DevicePixelRatio
                stroke_color: Theme.accent
            }
        }

        QQC2.Label{
            id:storageLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Storage usage:" + Monitor.storageUsage + " %")
        }

        Item{
            Layout.preferredHeight: 4 * DevicePixelRatio
            Layout.preferredWidth: parent.width - 140 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DashLine{
                id:storageDashLine
                anchors.fill: parent
                stroke_width: 2 *  DevicePixelRatio
                stroke_color: Theme.accent
            }
        }

        QQC2.Label{
            id:processLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Processes: " + Monitor.currentProcess)
        }

        Item{
            Layout.preferredHeight: 4 * DevicePixelRatio
            Layout.preferredWidth: parent.width - 140 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DashLine{
                id:processDashLine
                anchors.fill: parent
                stroke_width: 2 *  DevicePixelRatio
                stroke_color: Theme.accent
            }
        }

        Item {
            // spacer item
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
    // ----- Qt provided non-visual children
    Timer {
        interval: 1000; running: true; repeat: true;
        onTriggered: Monitor.updateSystemInfo()
    }

    // ----- Custom non-visual children

    // ----- JavaScript functions
}

