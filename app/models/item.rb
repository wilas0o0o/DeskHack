class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post
  belongs_to :category

  validates :name, presence: true, length: { maximum: 30 }
  validates :manufacturer, presence: true, length: { maximum: 30 }
  validate :post_items_size_validate

  ITEM_MAX = 10
  def post_items_size_validate
    if post && post.items.size > ITEM_MAX
      errors.add(:base, 'アイテムは最大１０個までです')
    end
  end
end
