import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2

import "../common"
Item {
    id:aboutPage
    // ----- Property Declarations
    // Required properties should be at the top.
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.

    Component.onCompleted: {
        console.log("About page completed")
    }
      // ----- Visual children.
    QQC2.Label {
        id:aboutLabel

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        padding: 2 * dp
        color:"white"
        font {
            family: font_families
            pointSize: 24
            italic: true
        }
        text: qsTr("about")
    }
}
