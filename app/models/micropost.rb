class Micropost < ApplicationRecord
  belongs_to :user
  has_many :replayposts, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }, allow_blank: true
  validates :picture, presence: true
  validate  :picture_size
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:profpicture, "5MB以上のファイルはアップロードできません")
    end
  end
end
