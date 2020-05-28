require "BCrypt"
class User < ApplicationRecord


  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :name, :address, :city, :state, :zip

  has_secure_password

  enum role: %w(default merchant admin)
end
