import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12


QQC2.Label {
    id:control

    property bool isEasterEgg:     false
    property bool isEasterEggHand: false
    property int easterEggCounter: 16

    elide: Text.ElideRight
    horizontalAlignment: Qt.AlignHCenter
    verticalAlignment: Qt.AlignVCenter

    signal showEasterEgg(string msg, int delay)

    MouseArea{
        id:icImageMouseArea
        anchors.fill: parent

        cursorShape: isEasterEggHand ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            Qt.callLater(decCounter);

            if (easterEggCounter < 8  && ! isEasterEggHand ){
                isEasterEggHand = true
                control.showEasterEgg( qsTr("A little more and you are at the target!"), 2000)
            }
            if (easterEggCounter == 0 ){
                control.showEasterEgg( qsTr("You found an easter egg!"), 3500)
                clearEasterEggCounter()
            }
        }
    }

    function decCounter(){
        easterEggCounter--
    }

    function clearEasterEggCounter(){
        easterEggCounter = 16
        isEasterEggHand = false
    }
}
