# spec/models/review_spec.rb
RSpec.describe Review, type: :model do
  it "exige rating de 1..5" do
    review = build(:review, rating: 6)
    expect(review).to be_invalid
  end
end
