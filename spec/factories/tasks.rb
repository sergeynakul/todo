FactoryBot.define do
  factory :task do
    description { 'MyText' }
    expiration_time { '2019-10-27 18:43:50' }
    todo_list

    trait :invalid do
      description { nil }
    end
  end
end
