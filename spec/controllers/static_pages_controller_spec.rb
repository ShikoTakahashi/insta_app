require 'rails_helper'
RSpec.describe StaticPagesController, type: :request do
  describe "homeの機能テスト" do

    before do
      get root_path
    end

    it "/に正常にアクセスできる" do
      expect(response).to have_http_status(:ok)
    end
  end
end
