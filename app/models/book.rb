# app/models/book.rb
class Book < ApplicationRecord
  has_many :loans, dependent: :restrict_with_error
  has_many :reviews, dependent: :destroy

  validates :title, :author, :category, presence: true
  validates :total_quantity, :available_quantity,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :available_not_greater_than_total

  def available_not_greater_than_total
    if available_quantity > total_quantity
      errors.add(:available_quantity, "não pode ser maior que o total")
    end
  end

  def average_rating
    reviews.average(:rating)&.to_f&.round(1)
  end
end
