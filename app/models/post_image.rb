class PostImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post, optional: true
  has_many :colors, dependent: :destroy

  validates :image, presence: true
end
