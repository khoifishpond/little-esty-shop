require 'rails_helper'

describe "User registration form", :logged_out do
  it "creates new user" do
    visit root_path

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    username = "funbucket13"
    password = "test"

    fill_in 'user_username', with: username
    fill_in 'user_password', with: password

    click_on "Create User"
    expect(page).to have_content("Welcome, #{username}!")
  end

  it 'keeps a user logged in after registering', :logged_out do
    visit root_path

    click_on "Create Account"

    username = "funbucket13"
    password = "test"

    fill_in 'user_username', with: username
    fill_in 'user_password', with: password
    choose 'user_role_admin'
    click_on "Create User"

    expect(current_path).to eq(admin_path)
    expect(page).to have_content("Welcome, #{username}!")
  end

  describe "Logging In", :logged_out do
    it "can log in with valid credentials" do
      user = User.create(username: "funbucket13", password: "test")

      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :username, with: user.username
      fill_in :password, with: user.password

      within("#login") do
        click_on "Log In"
      end

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{user.username}")
      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Create Account")
      expect(page).to_not have_link("Log In")
    end

    it "can log out" do
      visit root_path
      click_on "Create Account"
      expect(current_path).to eq(new_user_path)
      username = "funbucket13"
      password = "test"
      fill_in 'user_username', with: username
      fill_in 'user_password', with: password
      click_on "Create User"

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Log In")
      expect(page).to have_link("Create Account")
      expect(page).to_not have_link("Log Out")
    end

    it "cannot log in with bad credentials", :logged_out do
      user = User.create(username: "funbucket13", password: "test")

      visit root_path

      click_on "Log In"

      fill_in :username, with: user.username
      fill_in :password, with: "incorrect password"

      within("#login") do
        click_on "Log In"
      end

      expect(current_path).to eq(login_path)

      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end
