class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]
	before_action :set_comment, only: [:destroy]
	before_action :authorize_user, only: [:destroy]
  def create
  	
  	comment=Comment.create(content: params[:comment][:content], user_id: current_user.id, post_id: params[:comment][:post_id])

    #UserMailer.new_comment(comment.id).deliver_now
    #NewCommentEmailWorker.perform(comment.id)

    #this will pass this class waali queue mein comment id and classname
    Resque.enqueue(NewCommentEmailWorker,comment.id)
  	redirect_to root_path
  end

  def destroy
  	@comment.destroy
  	redirect_to root_path
  end

  private

  def set_comment
  	@comment= Comment.find(params[:id])

  end

  def authorize_user
  	if (@comment.user_id!=current_user.id)
  		redirect_to root_path
  	end
  end

end
