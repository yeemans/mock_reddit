class CreateSubreddits < ActiveRecord::Migration[6.1]
  def change
    create_table :subreddits do |t|
      t.string :title
      t.string :banner_link
      t.timestamps
    end
  end
end
