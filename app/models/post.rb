class Post < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	belongs_to :category, foreign_key: :category_id
	has_many :comments, foreign_key: :post_id
end