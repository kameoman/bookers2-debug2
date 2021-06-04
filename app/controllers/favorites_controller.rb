class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    # 現在のユーザーに基づいた良いねを作成するよという意味です。book_idは良いねをした記事はどれなのかを取ってくるもの
    @favorite = current_user.favorites.create(book_id: params[:book_id])

    @favorite.save

  end

  def destroy
    # どの投稿のいいねか対象を見つけてくる
    @book = Book.find(params[:book_id])
    # 上記でクリックなどして得た対象の投稿に対しての、良いねしたというレコード（データ）を見つける
    @favorite = current_user.favorites.find_by(book_id:@book.id)
    # いいねをしたというレコードを削除する
    @favorite.destroy

  end
end
