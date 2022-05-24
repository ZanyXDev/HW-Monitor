import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2

QQC2.ItemDelegate {
    id: delegateRoot

    // Do not allow user to click spacers and separators

    enabled: !isSpacer (index) && !isSeparator (index)

    // Alias to parent list view
    property ListModel model
    property ListView listView
    property int baseDimen: 8  * DevicePixelRatio

    background: Rectangle {
        color: "transparent"
    }

    height: calculateHeight(index)

    // Separator item
    QQC2.Frame{
        id:separatorItem
        visible: isSeparator (index)
        implicitHeight:  1 * DevicePixelRatio
        anchors{
            left: parent.left
            right: parent.right
        }
    }

    // Normal layout
    RowLayout {
        id:normalLayout
        visible: !isSpacer (index)

        spacing: baseDimen
        anchors.fill: parent

        Item {
            Layout.preferredWidth: baseDimen
        }

        Image {
            id:itemImage
            Layout.alignment: Qt.AlignVCenter

            smooth: true
            opacity: 0.54
            fillMode: Image.Pad
            source: iconSource (index)
            sourceSize: Qt.size (3  * baseDimen, 3  * baseDimen)
            verticalAlignment: Image.AlignVCenter
            horizontalAlignment: Image.AlignHCenter
        }

        Item {
            Layout.preferredWidth: baseDimen
        }

        QQC2.Label {
            id:itemLabel
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true

            opacity: 0.87
            text: itemText (index)
            font {
                family: font_families
                pointSize: 14
                weight: Font.Medium
            }
        }

        Item {
            Layout.preferredWidth: baseDimen
        }
    }

    // ----- JavaScript functions
    /**
      * Calculate height depending on the type of \sa item that we are
      */
    function calculateHeight(index){
        if (isSpacer (index)) {
            var usedHeight = 0
            for (var i = 0; i < model.count; ++i) {
                if (!isSpacer (i)) {
                    if (!isSeparator (i) || hasSeparatorText (i)){
                        usedHeight += 4 * baseDimen
                    }else{
                        usedHeight += 2 * baseDimen
                    }
                }
            }
            return Math.max (2 * baseDimen, listView.height - usedHeight)
        }

        if (enabled || hasSeparatorText (index)){
            return 4 * baseDimen
        }
        return 2 * baseDimen
    }

    //
    // Returns true if \c spacer is defined and is equal to \c true
    //
    function isSpacer (index) {
        if (typeof (model.get (index).spacer) !== "undefined"){
            return model.get (index).spacer
        }
        return false
    }

    //
    // Returns true if \c link is defined and is equal to \c true
    //
    function isLink (index) {
        if (typeof (model.get (index).link) !== "undefined"){
            return model.get (index).link
        }
        return false
    }

    //
    // Returns true if \c separator is defiend and is equal to \c true
    //
    function isSeparator (index) {
        if (typeof (model.get (index).separator) !== "undefined"){
            return model.get (index).separator
        }
        return false
    }

    //
    // Returns the icon for the drawer item
    //
    function iconSource (index) {
        if (typeof (model.get (index).pageIcon) !== "undefined"){
            return model.get (index).pageIcon
        }
        return ""
    }

    //
    // Returns the title for the drawer item
    //
    function itemText (index) {
        if (typeof (model.get (index).pageTitle) !== "undefined"){
            return model.get (index).pageTitle
        }
        return ""
    }

    //
    // Returns \c true if separatoText is correctly defined
    //
    function hasSeparatorText (index) {
        return isSeparator (index) && typeof (model.get (index).separatorText) !== "undefined"
    }

}
