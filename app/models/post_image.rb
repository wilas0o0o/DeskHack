class PostImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post

  validates :image, presence: true
end
