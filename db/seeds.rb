30.times do
  User.create!(
    first_name:  Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    birthday: Faker::Date.birthday(18, 65),
    gender: Faker::Gender.binary_type,
    password: "password"
  )
end

5.times do |n|
  FriendRequest.create!(
    sender_id: 1,
    receiver_id: n + 5,
    accepted: true
  )
  FriendRequest.create!(
    sender_id: n + 10,
    receiver_id: 1,
    accepted: true
  )
  FriendRequest.create!(
    sender_id: 1,
    receiver_id: n + 15,
    accepted: false
  )
  FriendRequest.create!(
    sender_id: n + 20,
    receiver_id: 1,
    accepted: false
  )
end

5.times do
  Post.create!(
    user_id: 1,
    content: Faker::Lorem.paragraph
  )
end

5.times do |n|
  Comment.create!(
    post_id: 1,
    user_id: n + 1,
    content: Faker::Lorem.paragraph
  )
end

5.times do |n|
  Like.create!(
    post_id: 1,
    user_id: n + 10
  )
end