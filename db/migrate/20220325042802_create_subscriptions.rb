class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user 
      t.belongs_to :subreddit
      t.timestamps
    end
  end
end
