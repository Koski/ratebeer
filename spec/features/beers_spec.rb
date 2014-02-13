require 'spec_helper'
include OwnTestHelper

describe "Beer" do

	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:user) { FactoryGirl.create :user }
	let!(:style) { FactoryGirl.create :style }

  	before :each do
    	sign_in(username:"Pekka", password:"Foobar1")
  	end

	it "saves a beer with valid parametres" do

		visit new_beer_path
		fill_in('beer_name', with:"iso 3")
		select('Lager', from:'beer[style_id]')
		select('Koff', from:'beer[brewery_id]')

		click_button "Create Beer"
		expect(page).to have_content "iso 3"
		expect(brewery.beers.count).to eq(1)
	end

	it "does not save a beer with an invalid name" do
		visit new_beer_path

		fill_in('beer_name', with:"A")
		select('Lager', from:'beer[style_id]')
		select('Koff', from:'beer[brewery_id]')

		click_button "Create Beer"
		expect(page).to have_content "Name is too short (minimum is 3 characters)"
		expect(brewery.beers.count).to eq(0)
	end
end