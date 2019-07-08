FactoryBot.define do
  sequence :email do |n|
    "john#{n}@mail.com"
  end

  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    email
    password { "password" }
  end

  factory :post do
    content { "Lorem" }
    association :user
  end

  factory :comment do
    content { "Lorem" }
    association :user
  end

  factory :like do
    association :post
    association :user
  end

  factory :friend_request do
    sender { create(:user) }
    receiver { create(:user) }
  end
end