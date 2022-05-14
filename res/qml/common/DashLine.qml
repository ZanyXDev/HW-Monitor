import QtQuick 2.12
import QtQuick.Shapes 1.0

Shape{
    id:control
    // ----- Property Declarations
    // Required properties should be at the top.
    property color stroke_color: "white"
    property int stroke_width: 2

    state: "OFF"
    ShapePath {
        id:shapePath

       // NumberAnimation on strokeWidth { id:anim;from: 1; to: 5; duration: 500; running: false}
        strokeColor: "white"
        strokeWidth: stroke_width
        strokeStyle: ShapePath.DashLine
        startX: 0
        startY: 0
        PathLine { x: control.width; y: 0 }

    }

    states: [
        State {
            name: "ON"
            PropertyChanges { target: shapePath; strokeWidth: 5}
        },
        State {
            name: "OFF"
            PropertyChanges { target: shapePath; strokeWidth: 1}
        }
    ]
    transitions: [
            Transition {
                from: "ON"
                to: "OFF"
                NumberAnimation {
                    target: shapePath;
                    property: "strokeWidth";
                    from: 1;
                    to: 5;
                    duration: 500
                }
            },
            Transition {
                from: "OFF"
                to: "ON"
                NumberAnimation {
                    target: shapePath;
                    property: "strokeWidth";
                    from: 5;
                    to: 1;
                    duration: 500
                }
            }
        ]
    // ----- JavaScript functions
    function toggle() {
        if (control.state === "ON")
            control.state= "OFF"
        else control.state = "ON"
        console.log("Dashline.state:"+control.state)
    }
}
