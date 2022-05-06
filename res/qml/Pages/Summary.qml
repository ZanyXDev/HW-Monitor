import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtGraphicalEffects 1.0


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
    ColumnLayout{
        id:mainScreenLayout
        anchors.fill: parent
        spacing: 2 *dp

        component InfoLabel:QQC2.Label {

            font { family: font_families}
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 2 * dp
            color:"white"
        }

        InfoLabel{
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

    }
    // ----- Qt provided non-visual children
    // ----- Custom non-visual children
    // ----- JavaScript functions

}

