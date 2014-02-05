import QtQuick 2.0
import QtMultimedia 5.0
Rectangle {
    id: window
    MediaPlayer {
        id: mediaplayer
        autoPlay: true
        //source: "http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8"
        //source: "sample.mp4"
        source: "STREAM_LINK"
    }

    VideoOutput {
        width:  500
        height: width*sourceRect.height/sourceRect.width

        source: mediaplayer

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAndYAxis
            onWheel: parent.width += wheel.angleDelta.y
        }
    }

    Text {
        text: "FFfuuu!"
        x:0
        y:parent.height/2
        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAndYAxis
        }
    }
}
