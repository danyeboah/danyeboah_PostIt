class User < ActiveRecord::Base
	has_many :posts, foreign_key: :user_id
	has_many :comments, foreign_key: :user_id
    has_many :votes, foreign_key: :user_id


  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6}, on: :create




  has_secure_password 
end
