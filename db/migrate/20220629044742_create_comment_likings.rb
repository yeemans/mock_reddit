class CreateCommentLikings < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_likings do |t|
      t.references :user
      t.references :comment
      t.boolean :is_upvote, :default => :true
      t.timestamps
    end
  end
end
