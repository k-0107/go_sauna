# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のシードデータ
# Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
#   admin.password = ENV['ADMIN_PASSWORD']
# end

Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

#ユーザー作成
mike = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Mike"
  user.introduction = "サウナ初心者ですが、毎日楽しく過ごしています！"
  user.favorite_drink = "コーヒー"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
  user.favorite_drink_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drink1.jpg"), filename:"sample-drink1.jpg")
end

jack = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "Jack"
  user.introduction = "サウナ好きなアウトドア派です。新しい発見を求めています。"
  user.favorite_drink = "スポーツドリンク"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
  user.favorite_drink_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drink2.jpg"), filename:"sample-drink2.jpg")
end

tarou = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Tarou"
  user.introduction = "仕事のストレスを発散するためにサウナに通っています！"
  user.favorite_drink = "ミネラルウォーター"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
  user.favorite_drink_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drink3.jpg"), filename:"sample-drink3.jpg")
end

#投稿作成
PostSauna.find_or_create_by!(name: "冒険者の桃源郷") do |post_sauna|
  post_sauna.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post_sauna.address = "フェイク都架空区虚構町4-5-6"
  post_sauna.price = "1500"
  post_sauna.impression = "初めてのサウナでしたが、とてもリフレッシュできました！"
  post_sauna.category = "ドライサウナ"
  post_sauna.star = 4
  post_sauna.user = mike
end

PostSauna.find_or_create_by!(name: "サウナの森") do |post_sauna|
  post_sauna.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post_sauna.address = "シミュレート県アドベンチャー市冒険町7-8-9"
  post_sauna.price = "1200"
  post_sauna.impression = "山奥にあるサウナ。自然に囲まれながら楽しめます！"
  post_sauna.category = "ミストサウナ"
  post_sauna.star = 5
  post_sauna.user = jack
end

PostSauna.find_or_create_by!(name: "ミスティックサウナ") do |post_sauna|
  post_sauna.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post_sauna.address = "ビジョン県イマジン市幻想町13-14-15"
  post_sauna.price = "1800"
  post_sauna.impression = "薬草の香りが漂うサウナ。心も体も癒されます！"
  post_sauna.category = "ミストサウナ"
  post_sauna.star = 2
  post_sauna.user = tarou
end

#コメント作成
PostComment.find_or_create_by!(comment: "素敵なサウナ体験ですね!", user: jack, post_sauna: PostSauna.find_by(name: "冒険者の桃源郷"))
PostComment.find_or_create_by!(comment: "この施設はきれいでしたか？", user: tarou, post_sauna: PostSauna.find_by(name: "サウナの森"))
PostComment.find_or_create_by!(comment: "最高のリラックス感があります！", user: mike, post_sauna: PostSauna.find_by(name: "ミスティックサウナ"))

# いいね作成
Favorite.find_or_create_by!(user: mike, post_sauna: PostSauna.find_by(name: "冒険者の桃源郷"))
Favorite.find_or_create_by!(user: jack, post_sauna: PostSauna.find_by(name: "サウナの森"))
Favorite.find_or_create_by!(user: tarou, post_sauna: PostSauna.find_by(name: "ミスティックサウナ"))

# フォロー・フォロワー関係作成
mike.follow(jack)
tarou.follow(jack)
jack.follow(mike)
