class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  mount_uploaders :images, ImageUploader

  validates :text, presence: true, length: { maximum: 140 }
  validates :situation, presence: true

  scope :working, -> { where(situation: 0) }
  scope :gaming, -> { where(situation: 1) }
  enum situation: { working: 0, gaming: 1 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
