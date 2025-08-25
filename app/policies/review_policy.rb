# app/policies/review_policy.rb
class ReviewPolicy < ApplicationPolicy
  def create?; user.present?; end
  def update?; user.present? && (record.user_id == user.id || user.admin?); end
  def destroy?; user.present? && (record.user_id == user.id || user.admin?); end
end
