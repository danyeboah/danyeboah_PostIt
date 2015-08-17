class Category < ActiveRecord::Base
  has_many :post_category_connects, foreign_key: :category_id
  has_many :posts, through: :post_category_connects

  validates :name, presence: true

  before_save :generate_slug


   # generate slug for urls
  def generate_slug
    count = 2
    slug = to_slug(self.name)
    duplicate = Category.find_by(slug: slug)

    while duplicate && duplicate != self
      slug = append_suffix(slug, count)
      duplicate = Category.find_by(slug: slug)
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
