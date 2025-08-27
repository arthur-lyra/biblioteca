require 'rails_helper'

RSpec.describe "Cadastro de Usuário", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "cadastra usuário com dados válidos" do
    visit new_user_registration_path
    fill_in "Nome", with: "Usuário Teste"
    fill_in "E-mail", with: "teste@exemplo.com"
    fill_in "Senha", with: "123456"
    fill_in "Confirme a senha", with: "123456"
    click_button "Cadastrar"
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end