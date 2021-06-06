class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @user_today_books = Book.where(user_id: current_user.id).where(created_at: Time.zone.now.all_day)
    @user_yesterday_books = Book.where(user_id: current_user.id).where(created_at: 1.day.ago.all_day)
    @book = Book.new

    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day

    @user_thisweek = Book.where(user_id: current_user.id).where(created_at: from...to)
    @user_lastweek = Book.where(user_id: current_user.id).where(created_at: (from - 6.day)...(to - 6.day))

  end

  def index
    @users = User.all
    @book = Book.new
    @books = Book.all

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end