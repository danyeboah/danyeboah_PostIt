class Post < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	has_many :comments, foreign_key: :post_id
  has_many :post_category_connects, foreign_key: :post_id
  has_many :categories, through: :post_category_connects

  validates :title, presence: true
end