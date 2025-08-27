FactoryBot.define do
  factory :review do
    rating { 5 }
    comment { "Ótimo livro!" }
    association :user
    association :book
  end
end