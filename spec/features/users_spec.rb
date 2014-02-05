require 'spec_helper'
include OwnTestHelper
BeerClub
BeerClubsController
describe "User" do
  let!(:user) { FactoryGirl.create :user }
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }

	before :each do	
	end

	describe "who has signed up" do
		it "can sign in with right credentials" do
			sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'User and password do not match!'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
    	fill_in('user_username', with:'Brian')
  		fill_in('user_password', with:'Secret55')
   		fill_in('user_password_confirmation', with:'Secret55')

    	expect{
        click_button('Create User')
    	}.to change{User.count}.by(1)
  	end
	end
  describe "who has signed up and signed in" do
    it "can see own ratings" do
      sign_in(username:"Pekka", password:"Foobar1")
      create_rating(beer:"iso 3", score:10)
      create_rating(beer:"Karhu", score:20)
      visit user_path(user)
      expect(page).to have_content 'Pekka Has made 2 ratings with an average of 15'
      expect(page).to have_content 'iso 3, 10'
      expect(page).to have_content 'Karhu, 20'
    end
  end
end