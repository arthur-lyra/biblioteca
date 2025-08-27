# spec/factories/books.rb
FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    category { "Computação" }
    total_quantity { 3 }
    available_quantity { 3 }
    synopsis { "..." }
  end
end
