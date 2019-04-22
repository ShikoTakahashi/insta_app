RSpec.feature "StaticPagesHome", type: :feature do
  #ログイン前のトップページ
  feature "ログイン画面が正常に機能している" do
    given!(:user) { create(:user) }
    background do
      visit root_path
    end

    scenario "ログインができる" do
      within "#login_input_field" do
        fill_in "メールアドレス", with: 'test@test.com'
        fill_in "パスワード", with: 'testuser'
        click_on "ログイン"
      end
      expect(page).to have_content "ログインしました。"
    end

    scenario "emailが入力されていない時エラーメッセージが表示される" do
      within "#login_input_field" do
        fill_in "メールアドレス", with: 'test@test.com'
        fill_in "パスワード", with: ' '
        click_on "ログイン"
      end
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
    end

    scenario "passwordが入力されていない時エラーメッセージが表示される" do
      within "#login_input_field" do
        fill_in "メールアドレス", with: ' '
        fill_in "パスワード", with: 'testuser'
        click_on "ログイン"
      end
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
    end

    scenario "'パスワードをお忘れた場合'をクリック時、new_user_password_pathへ移動する" do
      within "#login_input_field" do
        click_on 'パスワードをお忘れた場合'
      end
      expect(page).to have_current_path new_user_password_path
    end
  end
  #ログイン後のトップページ
  feature "ログイン後、ユーザーの固有ページが表示される" do
    given!(:user) { create(:user) }
    given!(:follow_user) { create(:second_user) }
    given!(:micropost) { create(:micropost, user: follow_user) }
    given!(:relationship) { Relationship.create(follower_id: user.id, followed_id: follow_user.id) }
    background do
      visit root_path
    end

    scenario "ユーザートップ画面が表示される" do
      within "#testuser_login" do
        click_on "テストユーザーでログイン"
      end
      expect(page).to have_current_path user_path user.id
    end

    scenario "トップページでフォローユーザーの投稿が表示される" do
      within "#testuser_login" do
        click_on "テストユーザーでログイン"
      end
      visit root_path
      expect(page).to have_content micropost.content
    end
  end
end
