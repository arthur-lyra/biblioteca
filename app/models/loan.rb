# app/models/loan.rb
class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book
  enum status: { active: 0, returned: 1, late: 2 }
  validates :borrowed_at, presence: true
end
