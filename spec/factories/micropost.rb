FactoryBot.define do
  factory :micropost, class: Micropost do
    content { "test" }
    picture { File.new("spec/factories/test_picture.jpg") }
  end
end
