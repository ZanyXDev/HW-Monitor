import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtGraphicalEffects 1.0

Image {
    id: control
    property bool rounded: true
    property bool adapt: true


    layer.enabled: rounded
    layer.effect: OpacityMask {
        maskSource: Item {
            width: control.width
            height: control.height
            Rectangle {
                anchors.centerIn: parent
                width: control.adapt ? control.width : Math.min(control.width, control.height)
                height: control.adapt ? control.height : width
                radius: Math.min(width, height)
            }
        }
    }
}
