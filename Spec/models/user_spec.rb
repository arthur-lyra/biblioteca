require 'rails_helper'

RSpec.describe User, type: :model do
  it "é inválido sem email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
    expect(user.errors[:email]).to be_present
  end

  it "é inválido com email inválido" do
    user = build(:user, email: "emailinvalido")
    expect(user).not_to be_valid
    expect(user.errors[:email]).to be_present
  end

  it "é válido com email e senha corretos" do
    user = build(:user, email: "teste@exemplo.com", password: "123456")
    expect(user).to be_valid
  end
end