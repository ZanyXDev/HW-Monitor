import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0

Item {
    id:control

    property string cardPrimaryTitle
    property string cardSecondaryText
    property string cardSubtitle

    property string iconSource
    property size iconSize: Qt.size (72, 72)

    property color primaryColor: Material.color(Material.primary)
    property color accentColor: Material.color(Material.accent)
    property color backgroundColor:  Material.color(Material.background)
    property color foregroundColor:  Material.color(Material.foreground)
    property bool flat: control.enabled && control.Material.elevation > 0

    property int radius: 4 * DevicePixelRatio
    property int elevation: 2 * DevicePixelRatio

    property bool isSperateLineShow: false
    property var actions
    implicitHeight: 120 * DevicePixelRatio
    implicitWidth:  160 * DevicePixelRatio
    QQC2.Pane {
        id:card
        spacing: 2 * DevicePixelRatio
        anchors.margins: 0
        anchors.fill: parent

        Material.elevation: control.elevation

        background: Rectangle {
            border.color: flat ? Qt.rgba(0,0,0,0.2) : "transparent"

            color: primaryColor

            radius: control.elevation > 0 ? control.radius : 0

            layer.enabled: flat
            layer.effect: ElevationEffect {
                elevation: control.elevation
            }
        }

        ColumnLayout {
            id:cardHLayout
            anchors.fill: parent
            spacing: 4 * DevicePixelRatio
            RowLayout{
                id:infoRowLayout
                Layout.fillWidth: true
                Layout.preferredHeight: (4 * DevicePixelRatio) + 72
                spacing:4 * DevicePixelRatio
                RoundImage{
                    id:roundIconImage
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                    source: iconSource
                    sourceSize: iconSize
                }
                ColumnLayout{
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    spacing:4 * DevicePixelRatio
                    QQC2.Label{
                        id:primaryLabel
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                        Layout.preferredHeight:24
                        Layout.fillWidth: true
                        font {
                            family: font_families
                            bold: true
                            pointSize: 14
                        }
                        text: cardPrimaryTitle
                    }
                    Rectangle{
                        id:secondaryLabel
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                        Layout.preferredHeight:24
                        Layout.fillWidth: true
                        color:"yellow"
                    }
                }
            }

            QQC2.Frame{
                id:spacerFrame
                Layout.fillWidth: true
                Layout.preferredHeight: 1 * DevicePixelRatio
            }
            RowLayout{
                id:subtitleRowLayout
                Layout.fillWidth: true
                Layout.preferredHeight: (4 * DevicePixelRatio) + 72
                spacing:4 * DevicePixelRatio
                Item {
                    // spacer item
                    Layout.fillWidth:  true
                }
                QQC2.Label{
                    id:subTitleLabel

                    Layout.fillWidth: true
                    font {
                        family: font_families
                        bold: true
                        pointSize: 10
                    }
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                    text: cardSubtitle
                }
            }
            Item { Layout.fillHeight:  true  }
            RowLayout{
                id:btnRowLayout
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 2 * DevicePixelRatio
                QQC2.Button{
                    id:btn
                    text: "Action"
                }
                Item {
                    // spacer item
                    Layout.fillWidth:  true
                }
                QQC2.ToolButton{
                    id: btnShare
                    Layout.alignment: Qt.AlignTop | Qt.AlignRight

                    icon.source:  "qrc:/res/images/icons/ic_share.png"

                    onClicked: {
                        if (isDebugMode)
                            console.log("btnShare.click()")
                    }
                }
            }
            Component.onCompleted: {
                if (isDebugMode)
                    console.log("cardHLayout:",cardHLayout.height,cardHLayout.width)
            }
        }
    }

}
