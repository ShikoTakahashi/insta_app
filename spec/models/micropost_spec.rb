require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let!(:user) { create(:user) }
  let!(:micropost) { create(:micropost, user: user) }
  let!(:replay_user) { create(:second_user) }
  let!(:replaypost) { create(:replaypost, user: replay_user, micropost: micropost) }

  context "when micropost is valid" do
    it "全ての値が入っている場合" do
      expect(micropost).to be_valid
    end
  end

  context "バリデーションが機能しているか確認" do
    it "contentが141文字以上の場合" do
      micropost.content = "a" * 140
      expect(micropost).to be_valid
      micropost.content = "a" * 141
      expect(micropost).not_to be_valid
    end
    it "pictureが空白の場合" do
      micropost.picture = nil
      expect(micropost).not_to be_valid
    end
  end

  context "投稿が削除された場合" do
    it "投稿の返信が削除される" do
      expect{ micropost.destroy }.to change{ Replaypost.count }.by(-1)
    end
  end
end
