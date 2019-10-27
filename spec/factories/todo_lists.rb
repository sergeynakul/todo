FactoryBot.define do
  factory :todo_list do
    title { 'MyString' }

    trait :invalid do
      title { nil }
    end
  end
end
