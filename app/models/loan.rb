class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum :status, { active: 0, returned: 1, late: 2 }

  validates :borrowed_at, presence: true
  validate :user_can_only_have_one_active_loan

  private

  def user_can_only_have_one_active_loan
    if user.loans.where(status: :active).where.not(id: id).exists?
      errors.add(:base, "Você só pode alugar um livro por vez. Devolva o livro atual antes de alugar outro.")
    end
  end
end
