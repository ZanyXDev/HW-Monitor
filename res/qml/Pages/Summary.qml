import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtGraphicalEffects 1.0

import io.github.zanyxdev.qml_hwmonitor 1.0

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
    component InfoLabel:QQC2.Label {

        font { family: font_families}
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        padding: 2 * dp
        color:"white"
    }

    ColumnLayout{
        id:mainScreenLayout
        anchors.fill: parent
        spacing: 2 *dp

        InfoLabel{
            id:summaryLabel
            Layout.preferredHeight: 24 * dp
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
            Layout.topMargin: 10 *dp
            Layout.rightMargin: 10 *dp
            font {
                pointSize: 24
                italic: true
            }
            text: qsTr("Summary")
        }

        Item{
            id:uptimeBlock
            Layout.preferredHeight: 24 * dp
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.topMargin: 10 *dp
            RowLayout{
                id:uptimeLayout
                spacing: 10 * dp
                anchors.fill: parent
                Item {
                    // spacer item
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                InfoLabel{
                    id:uptimeLabel
                    Layout.alignment: Qt.AlignTop | Qt.AlignCenter
                    text: qsTr("Uptime:")
                    font { pointSize: 18 }

                }
                InfoLabel{
                    id:uptimeValueLabel
                    Layout.alignment: Qt.AlignTop | Qt.AlignCenter
                    text: Monitor.uptime
                    font { pointSize: 18 }
                }
                Item {
                    // spacer item
                    Layout.fillHeight: true
                    Layout.fillWidth: true
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
    // ----- JavaScript functions

}

