import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0


import io.github.zanyxdev.qml_hwmonitor 1.0
import Common 1.0
import Theme 1.0
import Pages 1.0

QQC2.Page {
    id:summaryPage

    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool pageActive:  QQC2.SwipeView.isCurrentItem
    property bool pageInitialized:          false

    // ----- Signal declarations
    signal swipeToPage(int pageIndex)
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
            if (isDebugMode)
                console.log("Page title:"+title+" pageAvtive ["+ pageActive+"]","pageInitialized ["+pageInitialized+"]")
        }
    }

    Component.onCompleted: {
        if (isDebugMode){
            console.log("Summary page completed"," pageAvtive ["+ pageActive+"]")
            console.log(summaryPage.height,summaryPage.width)
        }
    }
    // ----- Visual children.
    background:{ null }

    Flow {
        /// TODO Drag and drop https://habr.com/ru/post/134377/
        anchors.fill: parent
        anchors.margins: 8 * DevicePixelRatio
        spacing: 8 * DevicePixelRatio

        component BaseMCard: MaterialCard{
            primaryColor: Theme.primary
            accentColor: Theme.accent
            foregroundColor: Theme.foreground
            backgroundColor: Theme.background
            Material.elevation:2 * DevicePixelRatio
            width: (summaryPage.width / 2) - (12 * DevicePixelRatio)
            isSeparetedLineShow: true
            showActionButton: true
            actionButtonText: qsTr("Show more ...")
        }

        BaseMCard{
            id:uptimeCard

            iconSource:"qrc:/res/images/icons/ic_uptime.png"

            cardPrimaryTitle:qsTr("Uptime")
            cardSecondaryText:Monitor.uptime
            cardSubtitle: qsTr("Time's since last boot")

            onActionButtonClicked:{
                swipeToPage(PageEnums.Index.Uptime)
            }
        }

        BaseMCard{
            id:memoryCard
            iconSource:"qrc:/res/images/icons/ic_ram.png"
            cardPrimaryTitle:qsTr("Memory usage")
            cardSecondaryText:( Monitor.memoryUsage + " %")
            cardSubtitle: qsTr("Average value for last second's")
            showShareButton: true
            onActionButtonClicked:{
                swipeToPage(PageEnums.Index.Memory)
            }
        }

        BaseMCard{
            id:socCard
            iconSource:"qrc:/res/images/icons/ic_cpu.png"
            cardPrimaryTitle:qsTr("CPUs usage")
            cardSecondaryText:(Monitor.cpuUsage + " %")
            cardSubtitle: qsTr("Average value for last second's")
            showShareButton: true
            onActionButtonClicked:{
                swipeToPage(PageEnums.Index.Soc)
            }
        }
        BaseMCard{
            id:batteryCard
            iconSource:"qrc:/res/images/icons/ic_battery.png"
            cardPrimaryTitle:qsTr("Battery capacity")
            cardSecondaryText:(Monitor.battareyCapacity + " %")
            cardSubtitle: qsTr("Average value for last second's")
            showShareButton: true
            onActionButtonClicked:{
                swipeToPage(PageEnums.Index.Battery)
            }
        }
        BaseMCard{
            id:processCard
            iconSource:"qrc:/res/images/icons/ic_hardware.png"
            cardPrimaryTitle:qsTr("Processes")
            cardSecondaryText:(Monitor.currentProcess + " %")
            cardSubtitle: qsTr("Average value for last second's")
            showShareButton: true
            onActionButtonClicked:{
                swipeToPage(PageEnums.Index.Process)
            }
        }
        BaseMCard{
            id:storageCard
            iconSource:"qrc:/res/images/icons/id_sd-card.png"
            cardPrimaryTitle:qsTr("Storage usage")
            cardSecondaryText:(Monitor.storageUsage + " %")
            cardSubtitle: qsTr("Average value for last second's")
            showShareButton: true
            isRoundImage:true
            onActionButtonClicked:{
                swipeToPage(PageEnums.Index.Storage)
            }
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

