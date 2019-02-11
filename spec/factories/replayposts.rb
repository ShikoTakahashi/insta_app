FactoryBot.define do
  factory :replaypost do
    content { "MyText" }
    user { nil }
    micropost { nil }
  end
end
