require 'rails_helper'

describe "User registration form" do
  it "creates new user" do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq(new_user_path)

    username = "funbucket13"
    password = "test"

    fill_in 'user_username', with: username
    fill_in 'user_password', with: password

    click_on "Create User"
    expect(page).to have_content("Welcome, #{username}!")
  end

  it 'keeps a user logged in after registering' do
    visit root_path

    click_on "Register as a User"
    
    username = "funbucket13"
    password = "test"
    fill_in 'user_username', with: username
    fill_in 'user_password', with: password
    choose 'user_role_merchant'
    click_on "Create User"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, #{username}!")
  end

  describe "Logging In" do
    it "can log in with valid credentials" do
      user = User.create(username: "funbucket13", password: "test")
  
      visit root_path
  
      click_on "I already have an account"
  
      expect(current_path).to eq(login_path)
  
      fill_in :username, with: user.username
      fill_in :password, with: user.password
      click_on "Log In"
      
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{user.username}")
      expect(page).to have_link("Log out")
      expect(page).to_not have_link("Register as a User")
      expect(page).to_not have_link("I already have an account")
    end

    it "cannot log in with bad credentials" do
      user = User.create(username: "funbucket13", password: "test")
    
      visit root_path
    
      click_on "I already have an account"
    
      fill_in :username, with: user.username
      fill_in :password, with: "incorrect password"
    
      click_on "Log In"
      save_and_open_page
      expect(current_path).to eq(login_path)
    
      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end