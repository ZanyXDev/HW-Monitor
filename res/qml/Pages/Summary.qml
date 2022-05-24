import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtGraphicalEffects 1.0


import io.github.zanyxdev.qml_hwmonitor 1.0
import "../common"

QQC2.Page {
    id:summaryPage

    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool appInForeground:     Qt.application.state === Qt.ApplicationActive
    readonly property bool pageActive:          QQC2.StackView.status === QQC2.StackView.Active
    property bool pageInitialized:          false
     title:  qsTr("Summary")
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.

    // ----- Then attached properties and attached signal handlers.
    // ----- States and transitions.
    // ----- Signal handlers
    onAppInForegroundChanged: {
        if (appInForeground && pageActive) {
            if (!pageInitialized) {
                pageInitialized = true;


            }
        } else {
            console.log("onAppInForegroundChanged-> [appInForeground:"+appInForeground+", pageInitialized:"+pageInitialized+"]")
        }
    }
    onPageActiveChanged: {
        if (appInForeground && pageActive) {
            if (!pageInitialized) {
                pageInitialized = true;
                ///TODO move to app activeChanged()
                Monitor.init();
            }
        } else {
            console.log("onAppInForegroundChanged:[appInForeground"+appInForeground+", pageInitialized"+pageInitialized+"]")
        }
    }

    Component.onCompleted: {
        console.log("Summary page completed")
    }
    // ----- Visual children.
    background:{ null }

    ColumnLayout{
        id:mainScreenLayout
        anchors.fill: parent
        spacing: 2 * DevicePixelRatio

        QQC2.Label {
            id:summaryLabel

            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
            Layout.topMargin: 16 * DevicePixelRatio
            Layout.rightMargin: 10 * DevicePixelRatio

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 2 * DevicePixelRatio
            color:"white"
            font {
                family: font_families
                pointSize: 24
                italic: true
            }
            text: qsTr("Summary")
        }

        Item {
            // spacer item
            Layout.preferredHeight: 32 * DevicePixelRatio
            Layout.fillWidth: true
        }

        LinkButton{
            id:uptimeLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Uptime: " + Monitor.uptime)
        }

        Item{
            Layout.preferredHeight: 4 * DevicePixelRatio
            Layout.preferredWidth: parent.width - 140 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DashLine{
                anchors.fill: parent
            }
        }

        LinkButton{
            id:memoryUsageLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Memory usage: " + Monitor.memoryUsage + " %")
            toolTipText: qsTr("Tap for more information about memory usage")
            action: memoryUsageAction
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
                Connections {
                    target: memoryUsageLabel
                    function onHoverChanged() {
                        memoryDashLine.toggle()
                    }
                }
            }
        }

        LinkButton{
            id:cpuLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("CPUs:" + Monitor.cpuUsage + " %")
            toolTipText: qsTr("Tap for more information about CPUs usage")
            action: cpuUsageAction
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
                Connections {
                    target: cpuLabel
                    function onHoverChanged() {
                        cpuDashLine.toggle()
                    }
                }
            }
        }

        LinkButton{
            id:batteryCapacityLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Battery capacity:" + Monitor.battareyCapacity + " %")
            toolTipText: qsTr("Tap for more information about Battery")
            action: batteryInfoAction
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
                Connections {
                    target: batteryCapacityLabel
                    function onHoverChanged() {
                        batteryDashLine.toggle()
                    }
                }
            }
        }

        LinkButton{
            id:storageLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Storage usage:" + Monitor.storageUsage + " %")
            toolTipText: qsTr("Tap for more information about Storage usage")
            action: storageUsageAction
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
                Connections {
                    target: storageLabel
                    function onHoverChanged() {
                        storageDashLine.toggle()
                    }
                }
            }
        }

        LinkButton{
            id:processLabel
            Layout.preferredHeight: 24 * DevicePixelRatio
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * DevicePixelRatio
            font {
                family: font_families
                pointSize: 18
            }
            text: qsTr("Processes: " + Monitor.currentProcess)
            toolTipText: qsTr("Tap for more information about Processes")
            action: processesInfoAction
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
                Connections {
                    target: processLabel
                    function onHoverChanged() {
                        processDashLine.toggle()
                    }
                }
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
    Connections {
        target: memoryUsageLabel
        function hovered() {
            console.log("memoryUsageLabel hovered signal")
        }
    }
    // ----- JavaScript functions
}

