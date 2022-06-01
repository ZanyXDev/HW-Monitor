import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2

import Common 1.0

QQC2.Page {
    id:aboutPage

    // ----- Property Declarations
    // Required properties should be at the top.
     readonly property bool pageActive:  QQC2.SwipeView.isCurrentItem
    property int pageID
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.

    Component.onCompleted: {
        console.log("About page completed")
    }

    // ----- Visual children.
    background:{ null }

}
