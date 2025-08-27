FactoryBot.define do
  factory :loan do
    borrowed_at { Time.current }
    status { :active }
    association :user
    association :book
  end
end