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

  has_many :subscriptions
  has_many :subreddits, through: :subscriptions

  has_many :subreddit_moderations, foreign_key: :moderator_id
  has_many :moderated_subreddits, through: :subreddit_moderations

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
      user = User.create(username: data['name'],
        email: data['email'],
        password: Devise.friendly_token[0,20], 
        omniauth_pfp: data['image']
      )
    end 
    
    user
  end
  
end
