class Post < ApplicationRecord
  belongs_to :user

  mount_uploaders :images, ImageUploader
  validates :text, presence: true, length: { maximum: 140 }
  validates :situation, presence: true

  enum situation: { working: 0, gaming: 1 }
end
