require 'spec_helper'
include OwnTestHelper

describe "Rating" do 
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
  	visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:15)

  	expect {
  		click_button "Create Rating"
  	}.to change{Rating.count}.from(0).to(1)

  	expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15)
  end

  it "when given is shown in recent ratings" do
    create_rating(beer:"Karhu", score:25)
    create_rating(beer:"iso 3", score:19)
    expect(page).to have_content 'Karhu , 25'
    expect(page).to have_content 'iso 3 , 19'
  end

  it "when given and destroyed it doesnt persist in the system" do
    create_rating(beer:"Karhu", score:23)
    create_rating(beer:"iso 3", score:10)
    visit user_path(user)
    expect(user.ratings.count).to eq(2)
    expect(beer1.ratings.count).to eq(1)
    page.find('li', :text => 'iso 3, 10').click_link('delete')
    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(0)
  end
    
end