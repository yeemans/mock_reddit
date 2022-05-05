class AddDescriptionToSubreddits < ActiveRecord::Migration[6.1]
  def change
    add_column :subreddits, :description, :string
  end
end
