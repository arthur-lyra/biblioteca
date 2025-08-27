require 'rails_helper'

RSpec.describe Book, type: :model do
  it "é inválido sem título" do
    book = build(:book, title: nil)
    expect(book).not_to be_valid
    expect(book.errors[:title]).to include("can't be blank")
  end

  it "é inválido sem autor" do
    book = build(:book, author: nil)
    expect(book).not_to be_valid
    expect(book.errors[:author]).to include("can't be blank")
  end

  it "é válido com todos os campos obrigatórios" do
    book = build(:book)
    expect(book).to be_valid
  end
end