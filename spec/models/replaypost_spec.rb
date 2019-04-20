require 'rails_helper'

RSpec.describe Replaypost, type: :model do
  let!(:post_user) { create(:user) }
  let!(:micropost) { create(:micropost, user: post_user) }
  let!(:replay_user) { create(:second_user) }
  let!(:replaypost) { create(:replaypost, user: replay_user, micropost: micropost) }

  context "when replaypost is valid" do
    it "全ての値が入っている場合" do
      expect(replaypost).to be_valid
    end
  end

  context "バリデーションが機能しているか確認" do
    it "contentが141文字以上の場合" do
      replaypost.content = "a" * 140
      expect(replaypost).to be_valid
      replaypost.content = "a" * 141
      expect(replaypost).not_to be_valid
    end
  end
end
