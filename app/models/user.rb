class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  has_many :replayposts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  validates :full_name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, length: { maximum: 50 }
  validates :website, length: { maximum: 100 }, :format => URI::regexp(%w(http https)),
                      allow_blank: true
  validates :comment, length: { maximum: 140 }
  validate  :picture_size
  mount_uploader :profpicture, PictureUploader

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.user_attributes"] &&
        session["devise.user_attributes"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
      if data = session["devise.user_attributes"]
        user.provider = data["provider"] if user.provider.blank?
        user.uid = data["uid"] if user.uid.blank?
      end
    end
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    favorite_posts = Favorite.where(user_id: id)
    favorite_post_ids =
      favorite_posts.map { |favorite_post| favorite_post.micropost_id }
    Micropost.where("user_id IN (#{following_ids})", user_id: id).
      or(Micropost.where(id: favorite_post_ids))
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def picture_size
    if profpicture.size > 5.megabytes
      errors.add(:profpicture, "5MB以上のファイルはアップロードできません")
    end
  end
end
