require "bcrypt"
class User < ApplicationRecord
<<<<<<< HEAD


  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :name, :address, :city, :state, :zip
=======
  # validates :email, uniqueness: true, presence: true
  # validates_presence_of :password, require: true
  # validates_presence_of :name, :address, :city, :state, :zip

  validates_presence_of :name, :address, :city, :state, :zip, :email
  validates_presence_of :password, on: :create
  validates :email, uniqueness: true
  validates_confirmation_of :password
>>>>>>> d398b917930a21675da95da1629add981937ce86

  has_secure_password

  enum role: %w(default merchant admin)
end
