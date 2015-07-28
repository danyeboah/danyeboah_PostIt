class Category < ActiveRecord::Base
	has_many :posts, foreign_key: :category_id
end
