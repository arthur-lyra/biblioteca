class ApplicationController < ActionController::Base

  include Pundit::Authorization
  include Pagy::Backend  # necessário para usar Pagy nos controllers
  before_action :authenticate_user!  # se quiser área pública, remova daqui e use por-controller
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private
  def user_not_authorized
    redirect_to(root_path, alert: "Você não tem permissão para realizar essa ação.")
  end
end
# config/initializers/pagy.rb
require "pagy/extras/overflow"
Pagy::DEFAULT[:items] = 12
Pagy::DEFAULT[:overflow] = :last_page