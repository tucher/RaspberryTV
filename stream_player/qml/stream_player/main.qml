import QtQuick 2.0
import QtMultimedia 5.0
import QtWebKit 3.0
import ru.joof.TcpServer 1.0

Rectangle {
    id: window
    property string currentUrl: ""

    property var protocol
    Component.onCompleted: {
        console.log(server.protocol)
        //currentUrl = "http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8"
        currentUrl = "fffuuuuu"
        protocol = JSON.parse(server.protocol)
    }

    //    WebView {
    //        url: "http://tvrain.ru"
    //        anchors.fill: parent
    //    }
    MediaPlayer {
        id: mediaplayer
        autoPlay: false
        source: window.currentUrl
        onPlaybackStateChanged: console.log(playbackState)
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
            server.sendData("Pong!");
            console.log("Data from interface: " + data);
            var js ;
            try {
                js = JSON.parse(data);
            }
            catch(e) {
                console.log("Incoming data is not json, ignoring");
                return;
            }
            processInterfaceCommand(js);
        }
        onError: console.log(error)
        port: 8886
        onConnectedChanged: console.log(connected)
    }
    Text {
        text: "Interface is not connected"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "red"
        visible: !server.connected
    }
    Text {
        id: lastCmd
        text: ""
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "red"
        font.pixelSize: 25
        Timer {
                 interval: 2000
                 running: parent.text != ""
                 repeat: false
                 onTriggered: parent.text = ""
        }
    }
    Text {
        text: "Not playing!"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "red"
        visible: mediaplayer.playbackState != MediaPlayer.PlayingState
    }
    function processInterfaceCommand(command){
        var f = 0;
        for (var i = 0; i < protocol.length; i++) {
            if(protocol[i].cmd === command.cmd) {
                console.log("command received: ", command.cmd);
                var id = command.cmd;
                f = 1;
                if(id === "play") play();
                else if(id === "pause") pause();
                else if(id === "stop") stop();
                else if(id === "setUrl") setUrl(command["url"]);
                else f = 0;
                break;
            }
        }
        if(f === 0)
            console.log("Command not supported: ", command.cmd);
        else
            lastCmd.text = command.cmd
    }

    function play() {
        mediaplayer.play()
    }
    function pause() {
        mediaplayer.pause()
    }
    function stop() {
        mediaplayer.stop()
        mediaplayer.source = "fffuuu"
    }
    function setUrl(url) {
        mediaplayer.source = url
    }
}
