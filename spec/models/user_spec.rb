require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe "relationships" do
    it {should have_many :orders}
  end

  describe "roles" do
    it "can be created as an admin" do
      user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:2)
      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end

    it "can be created as a merchant" do
      user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:1)
      expect(user.role).to eq("merchant")
      expect(user.merchant?).to be_truthy
    end

    it "can be created as a default user" do
      user = User.create!(name:"Jill", address:"123 Street", city:"Cityville", state:"CO", zip: 80110, email: "email2@email.com", password: "abcd", password_confirmation:"abcd", role:0)
      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
  end
end
