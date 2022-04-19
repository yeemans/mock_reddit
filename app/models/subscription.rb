class Subscription < ApplicationRecord
  belongs_to :subreddit 
  belongs_to :user
end
