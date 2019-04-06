class UsersController < ApplicationController

  #require 'rest-client'
  #url = 'https://www.google.com/m8/feeds/contacts/full'

  # uri= URI.parse(url)
  # query = Rack::Utils.parse_query(uri.query)
  # query["userEmail"]=@user.email
  # uri.query = Rack::Utils.build_query(query)
  # uri.to_s
  #RequestClient.get url
  def profile_page
 		@user=User.find(params[:id])
  end

  def upload_avatar
  		@user=User.find(params[:id])
  		@user.avatar=params[:user][:avatar]
  		@user.save
  		redirect_to request.referrer
  end
end
