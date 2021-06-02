class FollowersController < ApplicationController
  def index
    @followers = User.find(params[:user_id]).followers
  end
  
  def show
    @followers = User.find(params[:user_id]).followers
    @followings = User.find(params[:user_id]).followings
    user = User.find(params[:user_id])
    @users = user.followers
  end
  

end
