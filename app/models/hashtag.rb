class Hashtag < ApplicationRecord
  has_many :post_hashtags, dependent: :destroy
  has_many :posts, through: :post_hashtags

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 30 }
end
