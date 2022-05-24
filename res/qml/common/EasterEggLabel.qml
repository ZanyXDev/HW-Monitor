import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtQuick.Layouts 1.12

QQC2.Label {
    id:control

    property bool isEasterEgg:     false
    property bool isEasterEggHand: false
    property int easterEggCounter: 8

    elide: Text.ElideRight
    horizontalAlignment: Qt.AlignHCenter
    verticalAlignment: Qt.AlignVCenter

    signal showEasterEgg(string msg)

    MouseArea{
        id:icImageMouseArea
        anchors.fill: parent

        cursorShape: isEasterEggHand ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            easterEggCounter--
            if (easterEggCounter < 3 ){
                isEasterEggHand = true
                control.showEasterEgg( qsTr("A little more and you are at the target!") )
            }
            if (easterEggCounter == 0 ){
                control.showEasterEgg( qsTr("You found an easter egg!"))
                clearEasterEggCounter()
            }

        }
    }

    function clearEasterEggCounter(){
        easterEggCounter = 6
        isEasterEggHand = false
    }
}
