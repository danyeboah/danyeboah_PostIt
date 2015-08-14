class Post < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	has_many :comments, foreign_key: :post_id
  has_many :post_category_connects, foreign_key: :post_id
  has_many :categories, through: :post_category_connects
  has_many :votes, as: :voteable

  validates :title, presence: true

  def vote_popular
    upvotes - downvotes
  end

  def upvotes
    self.votes.where(vote: true).size
  end

  def downvotes
    self.votes.where(vote: false).size
  end

end