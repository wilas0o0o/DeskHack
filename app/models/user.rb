class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :active_relationships, class_name: "Ralationship", foregin_key: "follwer_id"
  has_many :followings, through: "active_relationships", source: :follwed
  has_many :passive_relationships, class_name: "Relationship", foregin_key: "followed_id"
  has_many :followers, through: "passive_relationships", source: :follower

  validates :name, presence: true
  mount_uploader :avatar, AvatarUploader


end
