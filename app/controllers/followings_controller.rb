class FollowingsController < ApplicationController
  def index
    @followings = User.find(params[:user_id]).followings
  end

  def show
    @followings = User.find(params[:user_id]).followings
  end



end
