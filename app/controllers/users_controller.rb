class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @user_today_books = Book.where(user_id: current_user.id).where(created_at: Time.zone.now.all_day)
    @user_1day_books = Book.where(user_id: current_user.id).where(created_at: 1.day.ago.all_day)
    @user_2day_books = Book.where(user_id: current_user.id).where(created_at: 2.day.ago.all_day)
    @user_3day_books = Book.where(user_id: current_user.id).where(created_at: 3.day.ago.all_day)
    @user_4day_books = Book.where(user_id: current_user.id).where(created_at: 4.day.ago.all_day)
    @user_5day_books = Book.where(user_id: current_user.id).where(created_at: 5.day.ago.all_day)
    @user_6day_books = Book.where(user_id: current_user.id).where(created_at: 6.day.ago.all_day)

    
    @book = Book.new

    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day

    @user_thisweek = Book.where(user_id: current_user.id).where(created_at: from...to)
    @user_lastweek = Book.where(user_id: current_user.id).where(created_at: (from - 6.day)...(to - 6.day))
    
    
    @date1 = Date.current.strftime('%d日')
    @date2 = Date.current.ago(1.days).strftime('%d日')
    @date3 = Date.current.ago(2.days).strftime('%d日')
    @date4 = Date.current.ago(3.days).strftime('%d日')
    @date5 = Date.current.ago(4.days).strftime('%d日')
    @date6 = Date.current.ago(5.days).strftime('%d日')
    @date7 = Date.current.ago(6.days).strftime('%d日')
    
    @year = Date.current.strftime('%Y年''%m月')

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