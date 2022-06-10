  
  
    Image{
        id:test
      fillMode: Image.Pad
        source: "qrc:/res/images/soc.png"
         sourceSize: Qt.size (92,92)
    }
    
  AnimatedSprite {
        id:lightImage
        source: "qrc:/res/images/Sprites/anim_flash.png"
        frameWidth: 64
        frameHeight: 64
        frameCount: 11
        frameDuration: 500
        width: 24
        height: 24
        frameRate: 12

        interpolate: true
        loops: Animation.Infinite

    }

    AnimatedSprite {
        id:lightImage2
        source: "qrc:/res/images/Sprites/anim_flash.png"
        frameWidth: 64
        frameHeight: 64
        frameCount: 12
        frameDuration: 500
        width: 24
        height: 24
        frameRate: 12

        interpolate: true
        loops: Animation.Infinite

    }

    PathAnimation {
        target: lightImage
        duration: 5000
        orientation: PathAnimation.RightFirst
        anchorPoint: Qt.point(lightImage.width/2, lightImage.height/2)
        running: true

        loops: Animation.Infinite
        path: Path {
            id: lightAnimPath
            startX: control.width*0.4; startY: control.height*0.3
            PathCurve { x: control.width*0.8; y: control.height*0.2 }
            PathCurve { x: control.width*0.8; y: control.height*0.7 }
            PathCurve { x: control.width*0.1; y: control.height*0.6 }
            PathCurve { x: control.width*0.4; y: control.height*0.3 }

        }
    }

    Item {
        anchors.fill: parent

        function explode(){
            particles.burst(particles.emitRate)
        }

        ParticleSystem {
            id: particleSystem
            anchors.fill: parent
        }

        ImageParticle {
            source: "qrc:/res/images/Particle/particle.png"
            system: particleSystem
        }

        Emitter {
            id: shootingStarEmitter
            system: particleSystem
            enabled: true
            emitRate:  50
            lifeSpan: 2000
            x: lightImage.x + lightImage.width/2
            y: lightImage.y + lightImage.height/2
            velocity: PointDirection {xVariation: 8; yVariation: 8;}
            acceleration: PointDirection {xVariation: 12; yVariation: 12;}
            size: 32
            sizeVariation: 16
        }
        Emitter {
            id: shootingStarBurst
             system: particleSystem
            emitRate: 10
            lifeSpan: 2000
            x: lightImage.x + lightImage.width/2
            y: lightImage.y + lightImage.height/2
            velocity: PointDirection {xVariation: 60; yVariation: 60;}
            acceleration: PointDirection {xVariation: 40; yVariation: 40;}
            size: 24
            sizeVariation: 16
        }


    }


    PathAnimation {
        target: lightImage2
        duration: 5000
        orientation: PathAnimation.RightFirst
        anchorPoint: Qt.point(lightImage.width/2, lightImage.height/2)
        running: true

        loops: Animation.Infinite
        path: Path {
            id: lightAnimPath2
            startX: control.width*0.1; startY: control.height*0.1
            PathCurve { x: control.width*0.8; y: control.height*0.2 }
            PathCurve { x: control.width*0.8; y: control.height*0.7 }
            PathCurve { x: control.width*0.1; y: control.height*0.6 }
            PathCurve { x: control.width*0.1; y: control.height*0.1 }

        }
    }

   Item {
        id: rootDraw

        property int lineWidth: 8
        property color lineColor: "#FFF"
        property int point1x:10
        property int point1y:20
        property int point2x:30
        property int point2y:40
        property bool dottedAnimation: true

        Item {
            id: priv
            property int multiple: rootDraw.dottedAnimation ? 20 : 5;
        }

        Behavior on opacity {
            PropertyAnimation{ duration:1000 }
        }

        PathView {
            id: rooPath
            anchors.fill: parent
            model: (Math.abs(rootDraw.point1x - rootDraw.point2x)+ Math.abs(rootDraw.point1y - rootDraw.point2y))/priv.multiple
            interactive: false
            delegate: Rectangle{
                color:rootDraw.lineColor
                width: rootDraw.lineWidth
                height:rootDraw.lineWidth
                radius: rootDraw.lineWidth/2
                smooth: true
            }
            path: Path {
                startX: rootDraw.point1x;
                startY: rootDraw.point1y
                PathLine {
                    x:rootDraw.point2x;
                    y: rootDraw.point2y
                }
            }

            SequentialAnimation{
                running: rootDraw.dottedAnimation
                loops: -1
                PropertyAnimation{ target: rooPath; property: "offset"; to: 0; duration: 0 }
                PropertyAnimation{ target: rooPath; property: "offset"; to: 1; duration: 500 }
            }
        }
    }


  /// Other way use Connection https://www.pythonguis.com/tutorials/pyside6-qml-animations-transformations/
    //    Connections {
    //            target: backend

    //            function onUpdated(msg) {
    //                currTime = msg;
    //            }
    //        }
