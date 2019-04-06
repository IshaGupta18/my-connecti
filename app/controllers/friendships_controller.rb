class FriendshipsController < ApplicationController
	def create
		@friendship= current_user.friendships.build(:friend_id => params[:friend_id])
		@friendship.save
		#flash[:notice] = "Friend Added"
		redirect_to root_url
	end
end
