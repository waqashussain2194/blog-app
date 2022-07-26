FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Devise.friendly_token.first(8) }
    confirmed_at { Time.zone.now }

    trait :admin do
      after(:build) do |user|
        user.roles << FactoryBot.build(:role, :admin_role)
      end
    end

    trait :moderator do
      after(:build) do |user|
        user.roles << FactoryBot.build(:role, :moderator_role)
      end
    end
  end
end
