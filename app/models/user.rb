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
  
  before_save do 
    generate_token(:auth_token)
  end

  include Slug
  sluggable_column :username

  # generate random token for login
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column == self[column])
  end

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

  # send email to change password
  def send_password_reset_email
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save 
    Usermail.password_reset(self).deliver
  end

end
