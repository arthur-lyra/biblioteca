# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 1000 }
  validates :user_id, uniqueness: { scope: :book_id } # 1 review por livro/usuário
end
