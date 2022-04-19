class SubredditModeration < ApplicationRecord
    belongs_to :moderator, class_name: "User"
    belongs_to :moderated_subreddit, class_name: "Subreddit"
end
