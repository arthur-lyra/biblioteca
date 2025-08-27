class BookPolicy < ApplicationPolicy
  def index?; true; end
  def show?; true; end

  def create?; user&.admin?; end
  def update?; user&.admin?; end
  def destroy?; user&.admin?; end

  def borrow?
    user.present? && record.available_quantity > 0
  end

  def give_back?
    user.present?
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end