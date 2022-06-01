import QtQuick 2.12
import QtQuick.Particles 2.15

Item {
    id:control
    anchors.fill: parent
    // Dust/Smoke particles
    property bool showColors: true

    ParticleSystem {
        id: particleSystem
        anchors.fill: parent
    }

    ImageParticle {
        groups: ["smoke"]
        source: "qrc:/res/images/Particle/smoke.png"
        color: "#ffffff"
        alpha: 0.9
        opacity: 0.8
        colorVariation: control.showColors ? 0.9 : 0.0
        rotationVariation: 180
        system: particleSystem
    }

    Emitter {
        id:emitter_1
        y: control.height * 0.85

        anchors.horizontalCenter: parent.horizontalCenter
        enabled: false

        width: 200 + parent.width * 0.1
        height: control.height * 0.3

        emitRate:  8
        lifeSpan: 2000
        lifeSpanVariation: 1000
        group: "smoke"

        maximumEmitted: 1000

        size: 192
        sizeVariation: 64
        acceleration: PointDirection { y: -80; xVariation: 20 }
        system: particleSystem
    }

    Emitter {
        id:emitter_2

        enabled: false
        y: control.height * 0.9
        anchors.horizontalCenter: parent.horizontalCenter

        width: 200 + parent.width * 0.1
        height: control.height * 0.2

        emitRate: 10
        lifeSpan: 2000
        group: "smoke"

        maximumEmitted: 1000

        size: 192
        sizeVariation: 64
        acceleration: PointDirection { y: -20; xVariation: 40 }
        system: particleSystem
    }

    Turbulence {
        groups: ["smoke"]
        width: parent.width
        height: parent.height * 0.8
        strength: 60
        system: particleSystem
    }

    function explode(){
        emitter_1.burst(emitter_1.emitRate)
        emitter_2.burst(emitter_2.emitRate)
    }
}
