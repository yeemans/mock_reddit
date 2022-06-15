class Post < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :body]
  has_many :comments
  has_many :likings
  belongs_to :user
  has_rich_text :content
end
