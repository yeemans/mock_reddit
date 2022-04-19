class AddSubredditsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :subreddit, index: true
  end
end
