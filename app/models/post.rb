class Post < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	has_many :comments, foreign_key: :post_id
  has_many :post_category_connects, foreign_key: :post_id
  has_many :categories, through: :post_category_connects
  has_many :votes, as: :voteable

  validates :title, presence: true

  before_save :generate_slug

  # calculate upvotes - downvotes
  def vote_popular
    upvotes - downvotes
  end

  def upvotes
    self.votes.where(vote: true).size
  end

  def downvotes
    self.votes.where(vote: false).size
  end


  # generate slug for urls
  def generate_slug
    count = 2
    slug = to_slug(self.title)
    duplicate = Post.find_by(slug: slug)

    while duplicate && duplicate != self
      slug = append_suffix(slug, count)
      duplicate = Post.find_by(slug: slug)
      count += 1
    end
    
    self.slug = slug
  end

  # convert string to more friendly slug format
  def to_slug(str)
    str = str.strip
    str.gsub!(/\W/, '-')
    str.gsub!('-+', '-')
    str
  end

  # deal with appending to duplicate slugs
  def append_suffix(str, count)
    str = str.split('-')
    if str.last.to_i != 0
      return str.slice(0...-1).join('-') + "-" + count.to_s
    else
      return str.join('-') + '-' + count.to_s
    end
  end

  def to_param
    self.slug
  end

end