class User < ActiveRecord::Base
	has_many :posts, foreign_key: :user_id
	has_many :comments, foreign_key: :user_id
  has_many :votes, foreign_key: :user_id


  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}, on: :create

  has_secure_password

  before_save :generate_slug

  include Slug
  sluggable_column :username
  
   # check if current user is an administrator
  def is_admin?
    self.user_status == 'admin'
  end

  # check if current user is a moderator
  def is_moderator?
    self.user_status == 'moderator'
  end


   # check if current user created post or comment
  def is_creator?(submission)
    submission.user_id == self.id
  end
end
