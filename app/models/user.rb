class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  validates :full_name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, length: { maximum: 50 }

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.user_attributes"] && session["devise.user_attributes"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
      if data = session["devise.user_attributes"]
        user.provider = data["provider"] if user.provider.blank?
        user.uid = data["uid"] if user.uid.blank?
      end
    end
  end
end
