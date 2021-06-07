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
    
    
    
    @articles = @user_thisweek

    @article_by_day = @articles.group_by_day(:created_at).size
    # groupdateのgroup_by_dayメソッドで投稿日(created_at)に基づくグルーピングして個数計上。 
    # => {Wed, 05 May 2021=>23, Thu, 06 May 2021=>20, Fri, 07 May 2021=>3, Sat, 08 May 2021=>0, Sun, 09 May 2021=>12, Mon, 10 May 2021=>2}

    @chartlabels = @article_by_day.map(&:first).to_json.html_safe
    # 投稿日付の配列を格納。文字列を含んでいると正しく表示されないので.to_json.html_safeでjsonに変換。
    # => "[\"2021-05-05\",\"2021-05-06\",\"2021-05-07\",\"2021-05-08\",\"2021-05-09\",\"2021-05-10\"]"

    @chartdatas = @article_by_day.map(&:second)
    # 日別投稿数の配列を格納。
    # => [23, 20, 3, 0, 12, 2]
    

  end

  def index
    @users = User.all
    @book = Book.new
    @books = Book.all

  end
  
  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"

    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
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