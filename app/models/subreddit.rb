class Subreddit < ApplicationRecord
  include PgSearch::Model
  multisearchable against: :title

  has_one_attached :banner

  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions, source: :user
  has_many :posts

  has_many :subreddit_moderations, foreign_key: :moderated_subreddit
  has_many :moderators, through: :subreddit_moderations, source: :moderator

end
