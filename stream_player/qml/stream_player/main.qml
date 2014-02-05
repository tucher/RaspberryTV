import QtQuick 2.0
import QtMultimedia 5.0
Rectangle {
    MediaPlayer {
        id: mediaplayer
        source: "http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8"
    }

    VideoOutput {
        width:  parent.width
        height: parent.height
        source: mediaplayer
    }

    MouseArea {
        id: playArea
        anchors.fill: parent
        onPressed: mediaplayer.play();
    }
}
