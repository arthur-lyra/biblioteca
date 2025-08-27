require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  it "é inválida sem nota" do
    review = build(:review, rating: nil, user: user, book: book)
    expect(review).not_to be_valid
    expect(review.errors[:rating]).to be_present
  end

  it "é inválida com nota fora do intervalo" do
    review = build(:review, rating: 6, user: user, book: book)
    expect(review).not_to be_valid
    expect(review.errors[:rating]).to be_present
  end

  it "é inválida sem comentário" do
    review = build(:review, comment: nil, user: user, book: book)
    expect(review).not_to be_valid
    expect(review.errors[:comment]).to be_present
  end

  it "não permite mais de uma avaliação por usuário para o mesmo livro" do
    create(:review, user: user, book: book)
    segunda_review = build(:review, user: user, book: book)
    expect(segunda_review).not_to be_valid
  end

  it "é válida com nota e comentário corretos" do
    review = build(:review, rating: 5, comment: "Ótimo livro!", user: user, book: book)
    expect(review).to be_valid
  end
end