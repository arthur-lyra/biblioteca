# spec/models/book_spec.rb
require "rails_helper"

RSpec.describe Book, type: :model do
  it "é inválido sem título" do
    book = build(:book, title: nil)
    expect(book).to be_invalid
    expect(book.errors[:title]).to be_present
  end

  it "não permite available > total" do
    book = build(:book, total_quantity: 1, available_quantity: 2)
    expect(book).to be_invalid
  end
end
