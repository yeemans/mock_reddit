class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :authentication_keys => [:username]
         
  validates :username, uniqueness: true

  has_many :posts

  has_many :subscriptions
  has_many :subreddits, through: :subscriptions

  has_many :subreddit_moderations, foreign_key: :moderator_id
  has_many :moderated_subreddits, through: :subreddit_moderations

  has_one_attached :avatar
  has_one_attached :banner 
  
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
  # use this instead of email_changed? for Rails = 5.1.x
  def will_save_change_to_email?
    false
  end
end
