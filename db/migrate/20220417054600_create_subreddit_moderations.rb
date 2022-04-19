class CreateSubredditModerations < ActiveRecord::Migration[6.1]
  def change
    create_table :subreddit_moderations do |t|
      t.references :moderator, index: true, foreign_key: true
      t.references :moderated_subreddit, index: true, foreign_key: true
      t.timestamps
    end
  end
end
