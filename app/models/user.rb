class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, :presence =>true, :confirmation =>true
  validates_confirmation_of :password
  validates_presence_of :password, require: true
  validates_presence_of :name, :address, :city, :state, :zip

  has_secure_password
end
