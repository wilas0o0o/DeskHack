class Hashtag < ApplicationRecord
  has_many :post_hashtags
  has_many :posts, through: :post_hashtags

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
