import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12


QQC2.ItemDelegate {
    id: control

    property bool   isCurrent
    property string keyText
    property string valueText

    property color primaryColor: Material.color(Material.primary)
    property color highlightedColor: Material.color(Material.accent)
    property color bgColor:  Material.color(Material.background)
    property color foregroundColor:  Material.color(Material.foreground)

    property bool flat: enabled && Material.elevation > 0
    property int radius: 4 * DevicePixelRatio

    Material.elevation:  4 * DevicePixelRatio

    background:Rectangle {
        anchors.fill: parent
        border.color: control.flat ? Qt.rgba(0,0,0,0.2) : "transparent"
        color: primaryColor
        radius:  control.Material.elevation > 0 ? control.radius : 0
        layer.enabled: control.flat
        layer.effect: ElevationEffect {
            elevation: control.Material.elevation
        }
    }

    RowLayout {
        id:normalLayout

        anchors.fill: parent
        spacing: 4 * DevicePixelRatio

        component InfoLabel: QQC2.Label  {
            anchors.fill: parent
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            font {
                pointSize: 12
                family: font_families
            }
        }

        component ProportionalRect: Item {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            Layout.preferredHeight: 1
        }

        ProportionalRect {
            id:leftBlock
            Layout.preferredWidth: 78 * DevicePixelRatio
            InfoLabel {
                anchors.leftMargin: 4 * DevicePixelRatio
                id:itemKeyLabel
                text: keyText
                font { weight: Font.Medium }
            }
        }
        // Separator item
        QQC2.Frame{
            id:separatorItem
            Layout.fillHeight: true
            Layout.preferredWidth: 1 * DevicePixelRatio
        }

        ProportionalRect {
            id:rightBlock
            Layout.preferredWidth: 238 * DevicePixelRatio
            InfoLabel {
                id:itemValueLabel
                text: valueText
            }
        }

        Component.onCompleted: {
            if (isDebugMode){
                console.log("label:",keyText,valueText)
            }
        }
    }

}
