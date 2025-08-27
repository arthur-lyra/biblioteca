require 'rails_helper'

RSpec.describe BookPolicy do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:policy) { described_class.new(user, book) }

  it "permite acesso para qualquer usuário nas ações show e index" do
    expect(policy.show?).to be true
    expect(policy.index?).to be true
  end

  it "não permite criar, atualizar ou excluir para usuário comum" do
    expect(policy.create?).to be false
    expect(policy.update?).to be false
    expect(policy.destroy?).to be false
  end
end