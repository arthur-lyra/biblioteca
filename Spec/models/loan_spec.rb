require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book, available_quantity: 1) }
  let(:loan) { build(:loan, user: user, book: book, borrowed_at: Time.current) }

  it "permite criar empréstimo se usuário não tem empréstimo ativo" do
    loan = Loan.new(user: user, book: book, status: :active, borrowed_at: Time.current)
    expect(loan).to be_valid
  end

  it "não permite criar empréstimo se usuário já tem empréstimo ativo" do
    create(:loan, user: user, book: book, status: :active, borrowed_at: Time.current)
    novo_loan = Loan.new(user: user, book: book, status: :active, borrowed_at: Time.current)
    expect(novo_loan).not_to be_valid
  end
end