import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.12

QQC2.ProgressBar {
    id:control
    property color proBackgroundColor: "darkgrey"
    property color proTextColor: "white"
    property string proText: string

    property int proWidth: 2
    property real progress: 0
    property real proRadius: 2
    property int proPadding: 2

    value: (progress/100)

    padding: proPadding

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 16
        color: control.proBackgroundColor
        radius: control.proRadius

    }

    contentItem: Item {
        implicitWidth: 200
        implicitHeight: 10

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            radius: proRadius
            color: getColor(progress)
            //opacity: 0.7
        }
    }

    Text{
        id:progressBarText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: control.proTextColor
        font: control.font
        text: control.proText + " " + progress + " %"
        z:2
    }

    function getColor(percent){
        var m_color;
        if (percent >0 && percent <= 25){
            m_color ="lightgreen"
        }
        if (percent >25 && percent <= 50){
            m_color ="green"
        }
        if (percent >50 && percent <= 75){
            m_color ="darkgreen"
        }
        if (percent >75 && percent <= 80){
            m_color ="orange"
        }
        if (percent >80 && percent <= 90){
            m_color ="darkorange"
        }
        if (percent > 90 ){
            m_color ="red"
        }
        return m_color;
    }
}


