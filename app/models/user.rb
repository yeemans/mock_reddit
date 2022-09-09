class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :authentication_keys => [:username, :email]
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  
  include PgSearch::Model
  multisearchable against: :username

  has_many :posts
  has_many :likings
  has_many :comment_likings

  has_many :subscriptions
  has_many :subreddits, through: :subscriptions

  has_many :subreddit_moderations, foreign_key: :moderator_id
  has_many :moderated_subreddits, through: :subreddit_moderations

  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower
  
  #####################
  
  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  
  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user


  has_one_attached :avatar
  has_one_attached :banner

  has_many :messages

  validates_uniqueness_of :email
  validates_presence_of :username

  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }


  include PgSearch::Model
  multisearchable against: :username

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      @username = self.find_valid_username(data['name'])
      user = User.create(username: @username,
        email: data['email'],
        password: Devise.friendly_token[0,20], 
        omniauth_pfp: data['image']
      )
    end 
    
    user
  end

  def self.followed_accounts 
    return Following.where(:follower_id => self.id)
  end

  def self.find_valid_username(username)
    # change the username depending on how many people already have it 
    postfix = User.where(:username => username).length 
    username += postfix.to_s if postfix > 0
    while User.find_by(:username => username) 
      postfix += 1 
      username += postfix.to_s    
    end
    return username
  end
  
end
