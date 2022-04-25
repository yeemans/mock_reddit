class CreateSubredditModerations < ActiveRecord::Migration[6.1]
  def change
    create_table :subreddit_moderations do |t|
      t.integer :moderator_id, index: true, foreign_key: true
      t.integer :moderated_subreddit_id, index: true, foreign_key: true
      t.timestamps
    end
  end
end