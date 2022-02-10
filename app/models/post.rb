class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy

  accepts_nested_attributes_for :post_images, allow_destroy: true
  acts_as_taggable
  enum situation: { Working: 0, Gaming: 1 }

  validates :post_images, presence: true, length: { maximum: 4 }
  validates :text, presence: true, length: { maximum: 140 }
  validates :situation, presence: true

  scope :working, -> { where(situation: 0) }
  scope :gaming, -> { where(situation: 1) }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
