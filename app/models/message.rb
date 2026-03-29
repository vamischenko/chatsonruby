class Message < ApplicationRecord
  ALLOWED_IMAGE_TYPES = %w[image/jpeg image/png image/gif image/webp].freeze
  MAX_IMAGE_SIZE = 5.megabytes

  validates :content, presence: true, unless: :was_attached?
  validate :image_type_and_size, if: -> { image.attached? }

  belongs_to :user
  belongs_to :room
  has_one_attached :image

  private

  def was_attached?
    image.attached?
  end

  def image_type_and_size
    unless ALLOWED_IMAGE_TYPES.include?(image.content_type)
      errors.add(:image, :invalid_type, default: "は jpeg/png/gif/webp のみ許可されています")
    end
    if image.byte_size > MAX_IMAGE_SIZE
      errors.add(:image, :too_large, default: "は5MB以下にしてください")
    end
  end
end
