require 'spec_helper'

describe User do

  it "has the username set correctly" do
  	user = User.new username:"Pekka"
  	expect(user.username).to eq("Pekka")
  end

  it "is not save without a password" do
  	user = User.create username:"Pekka"

  	expect(User.count).to be(0)
  	expect(user).not_to be_valid
  end

  it "is not saved with too short username" do
  	user = User.create username:"a", password:"Kall3", password_confirmation:"Kall3"
  	expect(User.count).to be(0)
  	expect(user).not_to be_valid
  end

  it "is not saved with a password consisting only of characters" do
  	user = User.create username:"Antti", password:"Seppo", password_confirmation:"Seppo"
  	expect(User.count).to be(0)
  	expect(user).not_to be_valid
  end

  describe "with a proper password" do
  	
  	let(:user){User.create username:"Pekka", password:"Sep1", password_confirmation:"Sep1"}

  	it "is saved" do
  		expect(user).to be_valid
  		expect(User.count).to be(1)
  	end

  	it "with two ratings, average rating works correctly" do
  		rating = Rating.new score:10
  		rating2 = Rating.new score:20

  		user.ratings << rating
  		user.ratings << rating2

  		expect(user.ratings.count).to be(2)
  		expect(user.average_rating).to be(15)
  	end
  end
  

end
