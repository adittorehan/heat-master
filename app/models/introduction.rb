class Introduction < ApplicationRecord
  belongs_to :survey, touch: true
  has_one_attached :image

  validates :headline, :subheadline, presence: true
  validate :valid_file_upload_content_type
  validate :valid_file_upload_size

  private

  def valid_file_upload_content_type
    return unless image.attached?
    return if image.blob.content_type.in? ["image/jpeg", "image/png"]

    errors.add(:image, "Unsupported file type")
  end

  def valid_file_upload_size
    return unless image.attached?

    return if image.blob.byte_size < 12_582_912

    errors.add(:file_upload, "Uploaded file is too big. Maximum upload file size is 12MB")
  end
end
