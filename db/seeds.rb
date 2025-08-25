# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
# db/seeds.rb
require 'faker'

# Cria um usuário admin, se ainda não existir
unless User.exists?(email: "admin@lib.com")
  User.create!(
    name: "Admin",
    email: "admin@lib.com",
    password: "password123",
    role: :admin
  )
end

# Cria usuários comuns de exemplo
5.times do
  User.find_or_create_by!(email: Faker::Internet.unique.email) do |u|
    u.name = Faker::Name.name
    u.password = "password123"
    u.role = :user
  end
end

# Cria livros de exemplo
10.times do
  Book.find_or_create_by!(title: Faker::Book.unique.title) do |b|
    b.author = Faker::Book.author
    b.category = %w[Computação Matemática História Literatura].sample
    b.total_quantity = 3
    b.available_quantity = 3
    b.synopsis = Faker::Lorem.paragraph(sentence_count: 3)
  end
end

puts "Seeds carregadas com sucesso!"

