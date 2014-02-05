require 'spec_helper'



describe User do

  it "has the username set correctly" do
  	user = User.new username:"Pekka"
  	expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
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
  	
  	let(:user){ FactoryGirl.create(:user) }

  	it "is saved" do
  		expect(user).to be_valid
  		expect(User.count).to be(1)
  	end

  	it "with two ratings, average rating works correctly" do

  		user.ratings << FactoryGirl.create(:rating)
  		user.ratings << FactoryGirl.create(:rating2)

  		expect(user.ratings.count).to be(2)
  		expect(user.average_rating).to be(15)
  	end
  end

  describe "favorite beer" do

    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only one rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if many are rated" do
      create_beers_with_ratings(10, 4, 20, 10, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determinig it" do
      user.should respond_to :ravorite_style
    end
  end

end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score: score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end