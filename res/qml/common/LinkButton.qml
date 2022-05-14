import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Shapes 1.0

/**
 * Shows a Button that looks like a link
 * based on  <a href="https://api.kde.org/frameworks/kirigami/html/LinkButton_8qml_source.html">KDE kirigami LinkButton</a>
 * Uses the link color settings and allows to trigger an action when clicked.
 */


QQC2.Label {
    id: control

    property QQC2.Action action: null
    /**
     * @var Qt::MouseButtons acceptedButtons
     * This property holds the mouse buttons that the mouse area reacts to.
     * See <a href="https://doc.qt.io/qt-5/qml-qtquick-mousearea.html#acceptedButtons-prop">Qt documentation</a>.
     */
    property alias acceptedButtons: area.acceptedButtons
    /**
     * @var MouseArea ara
     * Mouse area element covering the button.
     */
    property alias mouseArea: area
    /** This property Enables accessibility of QML items.
      * See <a href="https://doc.qt.io/qt-5/qml-qtquick-accessible.html">Qt documentation</a>.
     */
    property color linkColor: "lightgreen"
    property color textColor: "white"

    property string toolTipText: "Tap for more information"

    property bool isActive: action && control.enabled && area.containsMouse

    Accessible.role: Accessible.Button
    Accessible.name: text
    Accessible.onPressAction: control.clicked(null)

    enabled: !action || action.enabled

    font.underline: isActive

    color: isActive ? linkColor : textColor

    QQC2.ToolTip.text: toolTipText
    QQC2.ToolTip.visible: toolTipText ? isActive : false

    text: action ? action.text : ""
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight

    signal pressed(QtObject mouse)
    signal clicked(QtObject mouse)
    signal test()

    onClicked: if (action) action.trigger()

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: isActive ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: control.clicked(mouse)
        onPressed: control.pressed(mouse)
        onEntered:  {
            console.log("emit test signal")
             control.test()
        }

    }
}


