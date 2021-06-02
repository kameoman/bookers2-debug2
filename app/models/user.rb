class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 
  has_many :active_relationships, class_name: 'Follow', foreign_key: 'user_id'
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'target_user_id'
  has_many :followings, through: :active_relationships, source: :target_user
  has_many :followers, through: :passive_relationships, source: :user




  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # コメントの追加、記事の削除と同時に削除する
	has_many :post_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  # いいねしたかの判定
  
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
  
end
