class Post < ApplicationRecord
  belongs_to :user
  
  validates :body
end
