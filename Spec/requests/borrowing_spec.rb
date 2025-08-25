# spec/requests/borrowing_spec.rb
require "rails_helper"

RSpec.describe "Borrowing", type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book, total_quantity: 1, available_quantity: 1) }

  it "permite empréstimo quando há estoque" do
    sign_in user
    post borrow_book_path(book)
    expect(response).to redirect_to(book_path(book))
    expect(book.reload.available_quantity).to eq(0)
  end
end
