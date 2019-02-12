class Micropost < ApplicationRecord
  belongs_to :user
  has_many :replayposts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }, allow_blank: true
  validates :picture, presence: true
  validate  :picture_size
  mount_uploader :picture, PictureUploader


  def favorite_post(user)
    favorites.create(user_id: user.id)
  end

  def unfavorite_post(user)
    favorites.find_by(user_id: user.id).destroy
  end

  def favorite_post?(user)
    favorited_users.include?(user)
  end

  def self.search(search)
    if search
      Micropost.joins("LEFT OUTER JOIN replayposts ON microposts.id = replayposts.micropost_id")
      .where(["replayposts.content LIKE ? OR microposts.content LIKE ?", "%#{search}%", "%#{search}%"])
    else
      Micropost.all
    end
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:profpicture, "5MB以上のファイルはアップロードできません")
    end
  end
end
