class FollowingsController < ApplicationController
  def index
    @followings = User.find(params[:user_id]).followings
  end

  def show
    @followings = User.find(params[:user_id]).followings
    @followers = User.find(params[:user_id]).followers
    user = User.find(params[:user_id])
    @users = user.followings
  end



end
