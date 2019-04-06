class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]
	before_action :set_post, only: [:destroy]
	before_action :authorize_user, only: [:destroy]
  def home
  	@post=Post.new
  	@posts=Post.all
  	@comment=Comment.new
    @users=User.all


    respond_to do |f|
      f.html
      f.json{
        if params[:details]=="true"
          return render json: @posts, each_serializer: PostDetailSerializer

        else
          return render json: @posts
        end

      }
    end
  end

  def create
  	@post=Post.create(content: params[:post][:content], user_id: current_user.id)
    #redirect_to action: "home"
    @comment=Comment.new
  end

  def destroy
  	@post.destroy
  	@post_id= @post.id
  	#redirect_to action: "home"  prevent refresh
  end

  private

  def set_post
  	@post= Post.find(params[:id])

  end

  def authorize_user
  	if (@post.user_id!=current_user.id)
  		redirect_to action: "home"
  	end
  end

end
