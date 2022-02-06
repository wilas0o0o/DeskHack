class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  mount_uploaders :images, ImageUploader

  validates :text, presence: true, length: { maximum: 140 }
  validates :situation, presence: true

  scope :working, -> { where(situation: 0) }
  scope :gaming, -> { where(situation: 1) }
  enum situation: { working: 0, gaming: 1 }
end
