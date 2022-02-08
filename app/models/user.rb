class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: "active_relationships", source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: "passive_relationships", source: :follower

  validates :name, presence: true

  # すでにフォローしているかどうか
  def followings?(user)
    followings.include?(user)
  end

  # フォローするメソッド
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  #フォローを外すメソッド
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  def self.search_for(content)
    User.where('name LIKE ?', '%' + content + '%')
  end
end
