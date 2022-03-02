class PostImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post, optional: true
  has_many :colors, dependent: :destroy

  validates :image, presence: true

  # pixelFractionの合計値
  def calc_pixelFraction
    sum = 0
    self.colors.each do |color|
      sum = sum + color.pixel_fraction
    end
    return sum
  end
end
