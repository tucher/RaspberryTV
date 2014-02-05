import QtQuick 2.0
import QtMultimedia 5.0
Rectangle {
    id: window
    MediaPlayer {
        id: mediaplayer
        autoPlay: true
        //source: "http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8"
        //source: "sample.mp4"
        source: "rtmp://tvrain-video.cdn.ngenix.net/secure/_definst_/TVRain_tv.stream?t=1391621900&h=nqnv83RCNxlp2OWPqWR3fw%3D%3D"
    }

    VideoOutput {
        width:  500
        height: width*sourceRect.height/sourceRect.width

        source: mediaplayer

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAndYAxis
        }
    }

    Text {
        text: "FFfuuu!"
        x:0
        y:parent.height/2
        id: txt
        MouseArea {
            anchors.fill: parent
            drag.target: txt
            drag.axis: Drag.XAndYAxis
        }
    }
}
