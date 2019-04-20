require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:micropost) { create(:micropost, user: user) }
  let!(:second_user) { create(:second_user) }
  let!(:second_post) { create(:micropost, user: second_user) }
  let!(:replaypost) { create(:replaypost, user: user, micropost: second_post) }

  context "when user is valid" do
    it "全ての値が入っている場合" do
      expect(user).to be_valid
    end
  end

  context "バリデーションが機能しているか確認" do
    it "full_nameが空白の場合" do
      user.full_name = " "
      expect(user).not_to be_valid
    end
    it "full_nameが51文字以上の場合" do
      user.full_name = "a" * 50
      expect(user).to be_valid
      user.full_name = "a" * 51
      expect(user).not_to be_valid
    end
    it "user_nameが空白の場合" do
      user.user_name = " "
      expect(user).not_to be_valid
    end
    it "user_nameが51文字以上の場合" do
      user.user_name = "a" * 50
      expect(user).to be_valid
      user.user_name = "a" * 51
      expect(user).not_to be_valid
    end
    it "emailが空白の場合" do
      user.email = " "
      expect(user).not_to be_valid
    end
    it "websiteの先頭にhttpまたはhttpsを含まない場合" do
      user.website = "https://test.com"
      expect(user).to be_valid
      user.website = "http://test.com"
      expect(user).to be_valid
      user.website = "://test.com"
      expect(user).not_to be_valid
      user.website = "://http"
      expect(user).not_to be_valid
    end
    it "websiteが101文字以上の場合" do
      user.website = "https://" + "a" * 92
      expect(user).to be_valid
      user.website = "https://" + "a" * 93
      expect(user).not_to be_valid
    end
    it "commentが141文字以上の場合" do
      user.comment = "a" * 140
      expect(user).to be_valid
      user.comment = "a" * 141
      expect(user).not_to be_valid
    end
  end
  context "ユーザーが削除された場合" do
    it "ユーザーの投稿が削除される" do
      expect{ user.destroy }.to change{ Micropost.count }.by(-1)
    end
    it "ユーザーの返信が削除される" do
      expect{ user.destroy }.to change{ Replaypost.count }.by(-1)
    end
  end
end
