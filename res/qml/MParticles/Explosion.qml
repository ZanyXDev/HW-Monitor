import QtQuick 2.12
import QtQuick.Particles 2.15

// https://russianblogs.com/article/2292554914/
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
        source: "qrc:/res/images/logo.svg"
        system: particleSystem
    }

    Emitter{
        id: particles
        system: particleSystem
        enabled: false
        startTime: 0

        anchors.centerIn: parent
        height:  parent.height / 2
        width: parent.width / 2

        emitRate: 50
        lifeSpan: 1000
        lifeSpanVariation: 2000

        maximumEmitted: 1000
        size: 5
        endSize: 40

        velocity: AngleDirection {
            angle: 360
            angleVariation: 50
            magnitude: 20
            magnitudeVariation: 20
        }
    }
}

