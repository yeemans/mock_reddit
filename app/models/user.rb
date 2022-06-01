class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :authentication_keys => [:username]
  
  include PgSearch::Model
  multisearchable against: :username

  has_many :posts

  has_many :subscriptions
  has_many :subreddits, through: :subscriptions

  has_many :subreddit_moderations, foreign_key: :moderator_id
  has_many :moderated_subreddits, through: :subreddit_moderations

  has_one_attached :avatar
  has_one_attached :banner

  has_many :messages

  validates_uniqueness_of :username
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }


  include PgSearch::Model
  multisearchable against: :username
  
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
