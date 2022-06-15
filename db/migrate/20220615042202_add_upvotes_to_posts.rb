class AddUpvotesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :upvotes, :integer
  end
end
