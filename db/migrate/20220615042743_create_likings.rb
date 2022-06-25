class CreateLikings < ActiveRecord::Migration[6.1]
  def change
    create_table :likings do |t|
      t.references :user 
      t.references :post
      t.boolean :is_upvote, :default => true
      t.timestamps
    end
  end
end
