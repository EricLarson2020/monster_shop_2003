require "rails_helper"

RSpec.describe "Register Index Page", type: :feature do
  it "basic user can log in" do 
    visit "/login"
        
   jack = User.create!({
      name: "Jack",
      address: "333 Jack Blvd",
      city: "Denver",
      state: "Colorado",
      zip: 83243,
      email: "jack@hotmail.com",
      password: "3455", 
      password_confirmation: "3455",
      role: 0
      })
      
    fill_in :email, with: "jack@hotmail.com"
    fill_in :password, with: "3455"
    click_on "Submit"
    expect(current_path).to eq("/profile")
    expect(page).to have_content("You are logged in as Jack")   
    end 

    it "merchant user can login" do 
      jack = User.create!({
        name: "Jack",
        address: "333 Jack Blvd",
        city: "Denver",
        state: "Colorado",
        zip: 83243,
        email: "john@hotmail.com",
        password: "3455", 
        password_confirmation: "3455",
        role: 1
        })

        visit "/login"
        fill_in :email, with: "john@hotmail.com"
        fill_in :password, with: "3455"
        click_on "Submit"
        expect(current_path).to eq("/merchant/dashboard")
        expect(page).to have_content("You are logged in as Jack")   
   
    end 

    it "admin user can login" do 
      jack = User.create!({
        name: "Jack",
        address: "333 Jack Blvd",
        city: "Denver",
        state: "Colorado",
        zip: 83243,
        email: "jake@hotmail.com",
        password: "3455", 
        password_confirmation: "3455",
        role: 2
        })

        visit "/login"
        fill_in :email, with: "jake@hotmail.com"
        fill_in :password, with: "3455"
        click_on "Submit"
        expect(current_path).to eq("/admin/dashboard") 
        expect(page).to have_content("You are logged in as Jack")     
    end 


end 
