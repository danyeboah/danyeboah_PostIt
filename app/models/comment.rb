class Comment < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	belongs_to :post, foreign_key: :post_id

  has_many :votes, as: :voteable

  validates :body, presence: true

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
