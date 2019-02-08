FactoryBot.define do
  factory :micropost do
    picture { "MyString" }
    content { "MyText" }
    user { nil }
  end
end
