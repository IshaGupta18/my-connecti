class NewCommentEmailWorker

	@queue = :emails
	#class function perform is default method of worker to send mail, queue mein kaunsa worker and and kaunsi comment id
	def self.perform(comment_id)

		puts('sending emailssss')
		UserMailer.new_comment(comment_id).deliver_now


	end                            


#QUEUE=* rake environment resque:work
#for the 3rd (bg server): run the resque server for ALL (*) QUEUEs in the redis server


end