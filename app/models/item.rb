class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post
  belongs_to :category

  validates :name, presence: true, length: { maximum: 30 }
  validates :manufacturer, presence: true, length: { maximum: 30 }
end
