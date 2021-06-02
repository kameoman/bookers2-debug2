class Book < ApplicationRecord
	belongs_to :user
	# 多くの良いねを受け取る可能性がある、記事の削除と同時に削除する（いいね）
	has_many :favorites, dependent: :destroy
	# コメントの追加、記事の削除と同時に削除する
	has_many :post_comments, dependent: :destroy


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
