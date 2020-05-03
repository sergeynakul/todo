FactoryBot.define do
  sequence :description do |n|
    "MyText #{n}"
  end

  factory :task do
    description
    expiration_time { Time.now + 1.year }
    todo_list

    trait :invalid do
      description { nil }
    end
  end
end
