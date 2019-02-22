User.create!(full_name: "田中太郎",
             user_name: "tanataro",
             email: "tanaka@tanaka.com",
             password: "foobar",
             provider: "facebook",
             uid: "1252628151553543")

User.create!(full_name: "鈴木一郎",
             user_name: "イチロー",
             email: "suzuki@suzuki.com",
             password: "suzuki",
             provider: "facebook",
             uid: "1252628151553544")

User.create!(full_name: "テストユーザー",
             user_name: "テストユーザー",
             email: "test@test.com",
             password: "testuser",
             provider: "facebook",
             uid: "1252628151553545")

# マイクロポスト
users = User.all
5.times do
picture = open("#{Rails.root}/db/fixtures/テスト風景.jpg")
content = "風景の写真"
users.each { |user| user.microposts.create!(picture: picture, content: content) }
end
5.times do
picture = open("#{Rails.root}/db/fixtures/食事.jpg")
content = "お昼ご飯を食べてます"
users.each { |user| user.microposts.create!(picture: picture, content: content) }
end
5.times do
picture = open("#{Rails.root}/db/fixtures/テスト風景.jpg")
content = "テスト"
users.each { |user| user.microposts.create!(picture: picture, content: content) }
end
