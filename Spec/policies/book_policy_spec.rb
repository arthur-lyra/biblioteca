# spec/policies/book_policy_spec.rb
require "rails_helper"

RSpec.describe BookPolicy do
  subject { described_class }

  let(:book) { build_stubbed(:book) }
  let(:user) { build(:user) }
  let(:admin) { build(:user, :admin) }

  it "permite admin criar/editar/excluir" do
    expect(subject.new(admin, book).create?).to be true
    expect(subject.new(admin, book).update?).to be true
    expect(subject.new(admin, book).destroy?).to be true
  end

  it "nega usuário comum criar/editar/excluir" do
    expect(subject.new(user, book).create?).to be false
  end
end
