class User < ApplicationRecord
  # validates :email, uniqueness: true, presence: true
  # validates_presence_of :password, require: true
  # validates_presence_of :name, :address, :city, :state, :zip

  validates_presence_of :name, :address, :city, :state, :zip, :email
  validates_presence_of :password, on: :create
  validates :email, uniqueness: true
  validates_confirmation_of :password

  has_secure_password

  enum role: %w(default merchant admin)
end
