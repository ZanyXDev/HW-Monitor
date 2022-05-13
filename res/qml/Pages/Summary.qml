import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.0

import io.github.zanyxdev.qml_hwmonitor 1.0
import "../common"

Item {
    id:summaryPage

    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool appInForeground:     Qt.application.state === Qt.ApplicationActive
    readonly property bool pageActive:          QQC2.StackView.status === QQC2.StackView.Active
    property bool pageInitialized:          false
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    anchors.fill: parent
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
                Monitor.init();
            }
        } else {
            console.log("onAppInForegroundChanged:[appInForeground"+appInForeground+", pageInitialized"+pageInitialized+"]")
        }
    }

    QQC2.StackView.onRemoved: {
        console.log("Summary page destroy")
        destroy();
    }

    Component.onCompleted: {
        console.log("Summary page completed")
    }
    // ----- Visual children.

    component DotShape:Shape{
        id:separatorHLine
        ShapePath {
            NumberAnimation on strokeWidth { from: 1; to: 5; duration: 500 }
            strokeColor: "white"
            strokeWidth: 2 * dp
            strokeStyle: ShapePath.DashLine
            startX: 0
            startY: 0
            PathLine { x: separatorHLine.width; y: 0 }
        }
    }

    ColumnLayout{
        id:mainScreenLayout
        anchors.fill: parent
        spacing: 2 * dp

        QQC2.Label {
            id:summaryLabel

            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
            Layout.topMargin: 16 *dp
            Layout.rightMargin: 10 *dp

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 2 * dp
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
            Layout.preferredHeight: 32 * dp
            Layout.fillWidth: true
        }

        LinkButton{
            id:uptimeLabel
            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            font { pointSize: 18 }
            text: qsTr("Uptime: " + Monitor.uptime)
        }

        Item{
            id:separatorUptime
            Layout.preferredHeight: 4 * dp
            Layout.preferredWidth: parent.width - 140 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 5 * dp

            layer.enabled: true
            layer.samples: 4
            DotShape{
                anchors.fill: parent
            }
        }

        LinkButton{
            id:memoryUsageLabel
            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * dp
            font { pointSize: 18 }
            text: qsTr("Memory usage: " + Monitor.memoryUsage + " %")
            toolTipText: qsTr("Tap for more information about memory usage")
            action: memoryUsageAction
        }

        Item{
            id:separatorMemoryUsage
            Layout.preferredHeight: 4 * dp
            Layout.preferredWidth: parent.width - 140 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DotShape{
                anchors.fill: parent
            }
        }

        LinkButton{
            id:cpuLabel
            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * dp
            font { pointSize: 18 }
            text: qsTr("CPUs:" + Monitor.cpuUsage + " %")
            toolTipText: qsTr("Tap for more information about CPUs usage")
            action: cpuUsageAction
        }

        Item{
            id:separatorCPU
            Layout.preferredHeight: 4 * dp
            Layout.preferredWidth: parent.width - 140 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DotShape{
                anchors.fill: parent
            }
        }

        LinkButton{
            id:battareyCapacityLabel
            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * dp
            font { pointSize: 18 }
            text: qsTr("Battery capacity:" + Monitor.battareyCapacity + " %")
            toolTipText: qsTr("Tap for more information about Battery")
            action: batteryInfoAction
        }

        Item{
            id:separatorbattareyCapacity
            Layout.preferredHeight: 4 * dp
            Layout.preferredWidth: parent.width - 140 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DotShape{
                anchors.fill: parent
            }
        }

        LinkButton{
            id:storageLabel
            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * dp
            font { pointSize: 18 }
            text: qsTr("Storage usage:" + Monitor.storageUsage + " %")
            toolTipText: qsTr("Tap for more information about Storage usage")
            action: storageUsageAction
        }

        Item{
            id:separatorStorage
            Layout.preferredHeight: 4 * dp
            Layout.preferredWidth: parent.width - 140 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DotShape{
                anchors.fill: parent
            }
        }

        LinkButton{
            id:processLabel
            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 * dp
            font { pointSize: 18 }
            text: qsTr("Processes: " + Monitor.currentProcess)
            toolTipText: qsTr("Tap for more information about Processes")
            action: processesInfoAction
        }

        Item{
            id:separatorProcess
            Layout.preferredHeight: 4 * dp
            Layout.preferredWidth: parent.width - 140 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            layer.enabled: true
            layer.samples: 4
            DotShape{
                anchors.fill: parent
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

