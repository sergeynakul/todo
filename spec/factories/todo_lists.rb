FactoryBot.define do
  factory :todo_list do
    title { 'MyString' }
    user

    trait :invalid do
      title { nil }
    end
  end
end
