require "bcrypt"
class User < ApplicationRecord

  validates_presence_of :name, :address, :city, :state, :zip, :email
  validates_presence_of :password, on: :create
  validates :email, uniqueness: true
  validates_confirmation_of :password
  has_many :orders

  belongs_to :merchant, optional: true

  has_secure_password

  enum role: %w(default merchant admin)
end
