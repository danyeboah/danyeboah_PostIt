class Category < ActiveRecord::Base
  has_many :post_category_connects, foreign_key: :category_id
  has_many :posts, through: :post_category_connects

  validates :name, presence: true

  before_save :generate_slug

  include Slug
  sluggable_column :name

end
