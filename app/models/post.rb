class Post < ApplicationRecord
  belongs_to :user
  belongs_to :situation

  validates :text, presence: true, length: { maximum: 140 }
end
