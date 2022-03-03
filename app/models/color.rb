class Color < ApplicationRecord
  belongs_to :post_image

  validates :hex, presence: true
  validates :pixel_fraction, presence: true
end
