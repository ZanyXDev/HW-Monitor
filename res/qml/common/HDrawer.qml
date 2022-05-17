import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.12


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
    property color iconBgColorLeft: "#de6262"
    property color iconBgColorRight: "#ffb850"

    //
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


    //
    // A list with functions that correspond with the index of each drawer item
    // provided with the \a pages property
    //
    // For a string-based example, check this SO answer:
    //     https://stackoverflow.com/a/26731377
    //
    // The only difference is that we are working with the index of each element
    // in the list view, for example, if you want to define the function to call
    // when the first item of the drawer is clicked, you should write:
    //
    //     actions: {
    //         0: function() {
    //             console.log ("First item clicked!")
    //         },
    //
    //         1: function() {}...,
    //         2: function() {}...,
    //         n: function() {}...
    //     }
    //
    property var actions

    //
    // Main layout of the drawer
    //
    ColumnLayout {
        spacing: 0
        anchors.margins: 0
        anchors.fill: parent

        //
        // Icon controls
        //
        Rectangle {
            z: 1
            height: 64 * DevicePixelRatio
            id: iconRect
            Layout.fillWidth: true

            Rectangle {
                anchors.fill: parent

                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point (0, 0)
                    end: Qt.point (parent.width, 0)

                    gradient: Gradient {
                        GradientStop { position: 0; color: iconBgColorLeft }
                        GradientStop { position: 1; color: iconBgColorRight }
                    }
                }
            }

            RowLayout {
                spacing: 8 * DevicePixelRatio

                anchors {
                    fill: parent
                    centerIn: parent
                    margins: 8 * DevicePixelRatio
                }

                Image {
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
                        color: "#fff"
                        text: iconTitle

                        elide: Text.ElideRight
                        font {
                            weight: Font.Medium
                            family: font_families
                            pointSize: 14
                        }
                    }

                    QQC2.Label {
                        color: "#fff"
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



        ListView {
            z: 0
            id: inlineListView

            currentIndex: -1

            focus: true
            clip: true

            Layout.fillWidth: true
            Layout.fillHeight: true

            highlightFollowsCurrentItem: true
            highlight: Component{
                Rectangle {
                    visible: isActiveItem( index )

                    color: Material.color(Material.Orange)
                    radius: 5 * DevicePixelRatio

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
                model: items
                width: parent.width
                listView:  inlineListView

                onClicked: {
                    runActions( index )
                    inlineListView.currentIndex = index
                    control.close()
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
    function runActions( index ){
        if ( isActiveItem(index) && (typeof (actions [index]) !== "undefined") )
            actions [index]()
        else
            console.log("actions[" + index +"] " + actions [index])
    }

    function isActiveItem (index){
        var isSpacer = false
        var isSeparator = false
        var item = items.get ( index )

        if (typeof (item) !== "undefined") {
            if (typeof (item.spacer) !== "undefined")
                isSpacer = item.spacer

            if (typeof (item.separator) !== "undefined")
                isSeparator = item.separator
        } else{
            console.log("item(" + index +") undefined" )
            return false
        }

        return (!isSpacer && !isSeparator)
    }

}
