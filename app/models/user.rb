class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum :role, { user: 0, admin: 1 }

  has_many :loans, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\.[cC][oO][mM]\z/, message: "formato de e-mail inválido" }
  validates :email, uniqueness: { case_sensitive: false, message: "já está em uso" }
  validates :name, length: { minimum: 2, maximum: 50, message: "deve ter entre 2 e 50 caracteres" }

end
