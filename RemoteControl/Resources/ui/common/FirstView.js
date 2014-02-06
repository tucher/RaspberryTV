//FirstView Component Constructor
function TestSocket() {
	// for (var i = 0; i < 256; i++) {
	//
	// var socket = Ti.Network.Socket.createTCP({
	// host : '192.168.0.' + i,
	// port : 22,
	// connected : function(e) {
	// Ti.API.info('Connected:' + e.socket.host);
	// alert('Connected:' + e.socket.host);
	// // Ti.Stream.pump(e.socket, readCallback, 1024, true);
	// // Ti.Stream.write(socket, Ti.createBuffer({
	// // value : 'GET http://tuchkov.org/index.html HTTP/1.1\r\n\r\n'
	// // }), writeCallback);
	// },
	// error : function(e) {
	// Ti.API.info('Error (' + e.errorCode + '): ' + e.error);
	// }
	// });
	// socket.connect();
	var request = new XMLHttpRequest();
	request.open('GET', 'http://tuchkov.org', true);
	request.onreadystatechange = function() {
		if (request.readyState == 4) {
			if (request.status == 200) {
				alert(request.responseText);
			}
		}
	};
	request.send(null);
}

// function writeCallback(e) {
// Ti.API.info('Successfully wrote to socket.');
// }
//
// function readCallback(e) {
// if (e.bytesProcessed == -1) {
// // Error / EOF on socket. Do any cleanup here.
//
// }
// try {
// if (e.buffer) {
// var received = e.buffer.toString();
// Ti.API.info('Received: ' + received);
// } else {
// Ti.API.error('Error: read callback called with no buffer!');
// }
// } catch (ex) {
// Ti.API.error(ex);
// }
// }
//}

function FirstView() {
	//create object instance, a parasitic subclass of Observable
	var self = Ti.UI.createView();

	var label = Ti.UI.createLabel({
		color : '#000000',
		text : String.format(L('welcome'), 'Titanium'),
		height : 'auto',
		width : 'auto'
	});
	self.add(label);

	label.addEventListener('click', function(e) {
		//alert(e.source.text);
		TestSocket();
	});

	return self;
}

module.exports = FirstView;
