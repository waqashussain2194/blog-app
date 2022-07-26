FactoryBot.define do
  factory :role do
    trait :admin_role do
      after(:build) do |role|
        role.name = 'admin'
      end
    end

    trait :moderator_role do
      after(:build) do |role|
        role.name = 'moderator'
      end
    end
  end
end
