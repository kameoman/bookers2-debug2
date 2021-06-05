class PostCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    # 投稿に紐づいたコメントを作成
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = book.id
    if comment.save

    else
      @post_comment = comment
      @book_user = book.user
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy


  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
