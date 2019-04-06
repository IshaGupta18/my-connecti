console.log('starting server on my own');
const http = require('http');
const hostname = 'localhost'; //no http, wo baad mein we'll build it
const port = '8000';
const server = http.createServer().listen(port,hostname); //LISTEN at this port
console.log('running at'+hostname+port);
var socketList = require('socket.io').listen(server);
socketList.sockets.on('connection',function(socket){ //unique id and some data of socket in the parameter
	console.log('connection established');
	socket.on('disconnect',function(){
		console.log('disconnected');
	});
	socket.on('join_chat_room',function(data){

		socket.join(data.chatroom_name);
		socketList.in(data.chatroom_name).emit('new_user_joined',data);
	});

	socket.on('send_message',function(data){
		socketList.in(data.chatroom_name).emit('receive_msg',data); 	
	});




});