import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2

QQC2.ItemDelegate {
    id: delegateRoot

    property int baseDimen: 8  * DevicePixelRatio
    property bool isSpacer:false
    property bool isSeparator:false
    property bool isDark:false
    property string iconSource
    property string itemText

    //implicitHeight: Math.max(separatorItem.height, itemImage.height,itemLabel.height, 32  * DevicePixelRatio)

    background: Rectangle {
        color: "transparent"
    }

    // Separator item
    QQC2.Frame{
        id:separatorItem
        visible: isSeparator
        implicitHeight:  1 * DevicePixelRatio
        anchors{
            left: parent.left
            right: parent.right
        }
    }

    // Normal layout
    RowLayout {
        id:normalLayout
        visible: !isSpacer

        spacing: baseDimen
        anchors.fill: parent

        Item { Layout.preferredWidth: baseDimen  }

        Image {
            id:itemImage
            Layout.alignment:  Qt.AlignHCenter | Qt.AlignVCenter
            smooth: true
            opacity: isDark ? 0.54 : 1.0
            fillMode: Image.Pad
            source: iconSource
            sourceSize: Qt.size (24,24)
        }

        Item { Layout.preferredWidth: baseDimen }

        QQC2.Label {
            id:itemLabel
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true

            text: itemText
            font {
                family: font_families
                pointSize: 14
                weight: Font.Medium
            }
        }

        Item { Layout.preferredWidth: baseDimen }
    }

    // ----- JavaScript functions
}
