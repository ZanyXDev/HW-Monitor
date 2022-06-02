import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.12
import QtQuick.Shapes 1.0

import Pages 1.0

QQC2.Drawer {
    id: control

    //
    // Default size options
    //
    implicitHeight: parent.height
    implicitWidth: Math.min (parent.width > parent.height ? 320 : 280,
                             Math.min (parent.width, parent.height) * 0.90)

    //
    // Icon properties
    //
    property string iconTitle: ""
    property string iconSource: ""
    property string iconSubtitle: ""
    property size iconSize: Qt.size (72, 72)

    property color primaryColor: Material.color(Material.primary)
    property color highlightedColor: Material.color(Material.accent)
    property color bgColor:  Material.color(Material.background)
    property color foregroundColor:  Material.color(Material.foreground)

    property bool highlighted: false
    property bool isDarkMode: false

    // List model that generates the page selector
    // Options for selector items are:
    //     - spacer: acts an expanding spacer between to items
    //     - pageTitle: the text to display
    //     - separator: if the element shall be a separator item
    //     - separatorText: optional text for the separator item
    //     - pageIcon: the source of the image to display next to the title
    //
    property alias items: inlineListView.model
    property alias index: inlineListView.currentIndex
    property int itemsCount:  inlineListView.model.count
        // ----- Signal declarations
        signal clickListItem(int itemIndex)

    // Main layout of the drawer
    ColumnLayout {
        id: mainLayout
        spacing: 2 * DevicePixelRatio
        anchors.margins: 0
        anchors.fill: parent

        // Icon controls
        QQC2.Pane {
            id: iconRect
            Layout.fillWidth: true

            z: 1
            Layout.preferredHeight: 64 * DevicePixelRatio
            RowLayout {
                spacing: 8 * DevicePixelRatio

                anchors {
                    fill: parent
                    centerIn: parent
                    //  margins: 8 * DevicePixelRatio
                }

                Image {
                    id:iconImage
                    source: iconSource
                    sourceSize: iconSize
                }

                ColumnLayout {
                    spacing: 8 * DevicePixelRatio
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Item {
                        Layout.fillHeight: true
                    }

                    QQC2.Label {
                        color: foregroundColor
                        text: iconTitle

                        elide: Text.ElideRight
                        font {
                            weight: Font.Medium
                            family: font_families
                            pointSize: 14
                        }
                    }

                    QQC2.Label {
                        color: foregroundColor
                        opacity: 0.87
                        text: iconSubtitle
                        elide: Text.ElideRight
                        font {
                            family: font_families
                            pointSize: 10
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
        QQC2.Frame{
            id:spacerFrame
            Layout.fillWidth: true
            Layout.preferredHeight: 1 * DevicePixelRatio
        }

        ListView {
            id: inlineListView

            Layout.fillWidth: true
            Layout.fillHeight: true

            z: 0
            currentIndex: -1
            focus: true
            clip: true
            highlightFollowsCurrentItem: control.highlighted


            highlight: Component{
                Rectangle {
                    visible: (!items.spacer && !items.separator)

                    color: highlightedColor
                    // radius: 5 * DevicePixelRatio

                    y: inlineListView.currentItem.y

                    Behavior on y {
                        SpringAnimation {
                            spring: 3
                            damping: 0.2
                        }
                    }
                }
            }

            delegate: DrawerItem {
                id:drawerItem
                width: parent.width
                implicitHeight:  ( model.spacer) ? ( 128 * DevicePixelRatio) : (model.separator) ? 4 * DevicePixelRatio   :  32 * DevicePixelRatio

                isSeparator: model.separator
                isSpacer:   model.spacer
                itemText:   enabled ? model.pageTitle: ""
                iconSource: enabled ? model.pageIcon: ""
                isDark: control.isDarkMode
                // Do not allow user to click spacers and separators
                enabled: !isSpacer  && !isSeparator

                onClicked: {
                    clickListItem( model.pageIndex )
                    inlineListView.currentIndex = index
                    //control.close()
                }
            }

            QQC2.ScrollBar.vertical: QQC2.ScrollBar {
                policy: inlineListView.contentHeight > inlineListView.height ?
                            QQC2.ScrollBar.AlwaysOn : QQC2.ScrollBar.AlwaysOff
            }
            keyNavigationEnabled: false // Disable key up and key down
            Component.onCompleted: currentIndex = 0
        }
    }
    // ----- JavaScript functions
}
