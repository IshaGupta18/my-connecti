// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .
window.addEventListener('load',function(){

	var userEmail = $('#current_user_email').html();
	if (userEmail){
		var socket = io.connect('http://localhost:8000');
		socket.on('connect',function(){
			console.log('handshook');
			socket.emit('join_chat_room',{
				'chatroom_name': 'mynewroom',
				'user_email': userEmail
			});
		

		socket.on('new_user_joined',function(data){
			console.log('new user has joined',data);
		});
		$('#send-message').unbind('click');
		$('#send-message').click(function(){
			let msg = $('#chat-message-input').val();
			if (msg!=''){
				socket.emit('send_message',{
					'message':msg,
					'user_email': userEmail,
					'chatroom_name': 'mynewroom'
				});
			}
		});

		socket.on('receive_msg',function(data){
			var className= 'self-message';
			if (data.user_email!=userEmail){
				className= 'other-message';

			}
			var newMessage = $('<li>',{
				'class': className
			});

			var messageText = $('<span>',{
				'html': data.message+'<br>'+data.user_email

			});
			newMessage.append(messageText);
			$('#chat-messages-list').append(newMessage);
		});



		});


	}

});