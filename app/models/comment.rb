class Comment < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	belongs_to :post, foreign_key: :post_id

  validates :body, presence: true

  include Voteable
end
