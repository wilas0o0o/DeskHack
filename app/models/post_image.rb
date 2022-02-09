class PostImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post, optional: true

  validates :image, presence: true
end
