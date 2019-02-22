require "rails_helper"

RSpec.describe User, type: :model do

  before do
    @user = User.create!(full_name: "testuser",
                         user_name: "test",
                          email: "test@test.com",
                          password: "foobar",
                          provider: "facebook",
                          uid: "12345678910")
  end

  context "when user is valid" do
    it "値が入っている場合" do
      expect(@user).to be_valid
    end
  end
end
