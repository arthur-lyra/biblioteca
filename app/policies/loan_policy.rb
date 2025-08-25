# app/policies/loan_policy.rb
class LoanPolicy < ApplicationPolicy
  def index?; user.present?; end
  def show?; user.present? && (record.user_id == user.id || user.admin?); end
end
