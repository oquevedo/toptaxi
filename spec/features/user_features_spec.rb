require 'spec_helper'

describe "Users" do

  describe "log in" do

    before :each do
      @user = FactoryGirl.create(:user, admin: true, active: true)
      visit root_path
    end

    it "with valid data" do
      fill_in "Email", :with => @user.email, :match => :prefer_exact
      fill_in "Contraseña", :with => @user.password, :match => :prefer_exact
      click_button "Ingresa", :match => :prefer_exact
      current_path.should eq(home_path)
    end

    it "does not login with invalid email" do
      fill_in "Email", :with => "wrong@email.com", :match => :prefer_exact
      fill_in "Contraseña", :with => @user.password, :match => :prefer_exact
      click_button "Ingresa", :match => :prefer_exact
      current_path.should eq("/log_in")
      page.should have_content("Contraseña o correo incorrectos")
    end

    it "does not login with invalid password" do
      fill_in "Email", :with => @user.email, :match => :prefer_exact
      fill_in "Contraseña", :with => "wrongpassword", :match => :prefer_exact
      click_button "Ingresa", :match => :prefer_exact
      current_path.should eq("/log_in")
      page.should have_content("Contraseña o correo incorrectos")
    end
  end

  describe "Create user" do

    before :each do
      @user = FactoryGirl.create(:user, admin: true, active: true)
      page.set_rack_session(user_id: @user.id)
      visit new_user_path
      current_path.should eq("/users/new")
      # fill_in "user[first_name]", :with => "Tester", :match => :prefer_exact
      # fill_in "user[last_name]", :with => "Tester", :match => :prefer_exact
    end

    it "creates user with valid data" do
      fill_in "user[email]", :with => "example@example.com", :match => :prefer_exact
      click_button "Regístrate"
      current_path.should eq(users_path)
    end

    it "fails creating user with existing email" do
      fill_in "user[email]", :with => "example@example.com", :match => :prefer_exact
      click_button "Regístrate"
      current_path.should eq("/users")
      page.should have_content("Email ya existe")
    end

  end
end