class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum :role, { user: 0, admin: 1 }

  has_many :loans, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
end
