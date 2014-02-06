import QtQuick 2.0
import QtMultimedia 5.0
import QtWebKit 3.0
import ru.joof.TcpServer 1.0
Rectangle {
    id: window
    property string currentUrl: ""
    Component.onCompleted: currentUrl = "http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8"
//    WebView {
//        url: "http://tvrain.ru"
//        anchors.fill: parent
//    }
    MediaPlayer {
        id: mediaplayer
        autoPlay: true
        source: window.currentUrl
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

    TcpServer {
        id: server
        onDataReceived: {
            server.sendData("Pong!")
            console.log(data)
        }
        onError: console.log(error)
        port: 8886
        onConnectedChanged: console.log(connected)
    }
    Text {
        text: server.connected ? "Interface is connected" : "Interface is not connected"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
