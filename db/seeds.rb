10.times do
  User.create!(username: Faker::Science.scientist, email: Faker::Internet.safe_email, password: Faker::Internet.password(8, 14))
end

20.times do
  Post.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraphs(4).join, user_id: rand(1..10))
end
