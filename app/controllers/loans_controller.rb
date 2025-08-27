class LoansController < ApplicationController
  def index
    @loans = current_user.loans.includes(:book).order(borrowed_at: :desc)
  end
end