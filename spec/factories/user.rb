FactoryBot.define do
  factory :user, class: User do
    full_name { "testuser" }
    user_name { "test" }
    email { "test@test.com" }
    password { "foobar" }
    provider { "facebook" }
    uid { "12345678910" }

    factory :second_user do
      full_name { "replayuser" }
      user_name { "replay" }
      email { "replaytest@test.com" }
      password { "foobar" }
      provider { "facebook" }
      uid { "12345678911" }
    end
  end
end
