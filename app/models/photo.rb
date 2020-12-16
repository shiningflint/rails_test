class Photo < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validate :photo_file?

  has_one_attached :photo_file
  belongs_to :user

  private

  def photo_file?
    photo_file_attribute = I18n.t('activerecord.attributes.photo.photo_file')
    photo_file_error = I18n.t('activerecord.errors.models.photo.attributes.photo_file.blank')
    errors.add(:base, "#{photo_file_attribute}#{photo_file_error}") unless photo_file.attached?
  end
end
