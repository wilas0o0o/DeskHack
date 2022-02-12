class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post
  belongs_to :category

  validates :name, presence: true
  validates :manufacturer, presence: true
end
