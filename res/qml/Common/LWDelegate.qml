import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2

QQC2.ItemDelegate {
    id: control

    property int baseDimen: 8  * DevicePixelRatio
    property bool   isCurrent
    property string keyText
    property string valueText

    background: Rectangle {
        color: "transparent"
    }

  MyDebugRect{
       anchors.fill: parent
  }

    RowLayout {
        id:normalLayout
        visible: false

        spacing: baseDimen
        anchors.fill: parent

        component InfoLabel: QQC2.Label  {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.fillWidth: true

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            font { family: font_families }
        }

        Item { Layout.preferredWidth: baseDimen  }

        InfoLabel {
            id:itemKeyLabel
            text: keyText
            font {
                pointSize: 14
                weight: Font.Medium
            }
        }

        Item { Layout.preferredWidth: baseDimen }

        InfoLabel {
            id:itemValueLabel
            text: valueText
            font { pointSize: 12}
        }

        Item { Layout.preferredWidth: baseDimen }
        Component.onCompleted: {
            console.log("label:",keyText,valueText)
        }
    }
}
