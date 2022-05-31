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
    property string actionButtonText

    property color primaryColor: Material.color(Material.primary)
    property color accentColor: Material.color(Material.accent)
    property color backgroundColor:  Material.color(Material.background)
    property color foregroundColor:  Material.color(Material.foreground)

    property size iconSize: Qt.size (72, 72)

    property int radius: 4 * DevicePixelRatio

    property bool isSeparetedLineShow: false
    property bool flat: control.enabled && control.Material.elevation > 0
    property bool showActionButton: false
    property bool showShareButton: false

    implicitHeight: 120 * DevicePixelRatio
    implicitWidth:  160 * DevicePixelRatio

    //https://doc.qt.io/qt-5/qtqml-syntax-signals.html#adding-signals-to-custom-qml-types
    signal actionButtonClicked()
    signal sharedButtonClicked()
    QQC2.Pane {
        id:card
        spacing: 2 * DevicePixelRatio
        anchors.margins: 0
        anchors.fill: parent

        Material.elevation:  control.Material.elevation

        background: Rectangle {
            border.color: control.flat ? Qt.rgba(0,0,0,0.2) : "transparent"

            color: primaryColor

            radius:  control.Material.elevation > 0 ? control.radius : 0

            layer.enabled: control.flat
            layer.effect: ElevationEffect {
                elevation: control.Material.elevation
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
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredHeight:24
                        Layout.fillWidth: true
                        font {
                            family: font_families
                            bold: true
                            pointSize: 14
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
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
                visible: isSeparetedLineShow
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
                QQC2.ToolButton{
                    id:btnAction
                    visible:showActionButton
                    text:actionButtonText

                    font {
                        family: font_families
                        capitalization:Font.MixedCase
                    }
                    onClicked: {
                        control.actionButtonClicked()
                        if (isDebugMode)
                            console.log("btnAction.click()")
                    }
                }
                Item {
                    // spacer item
                    Layout.fillWidth:  true
                }
                QQC2.ToolButton{
                    id: btnShare
                    visible: showShareButton
                    Layout.alignment: Qt.AlignTop | Qt.AlignRight

                    icon.source:  "qrc:/res/images/icons/ic_share.png"

                    onClicked: {
                        control.sharedButtonClicked()
                        if (isDebugMode)
                            console.log("btnShare.click()")
                    }
                }
            }
            Component.onCompleted: {
                if (isDebugMode){
                    console.log("control.Material.elevation:",control.Material.elevation,control.flat,radius)
                }
            }
        }
    }

}
