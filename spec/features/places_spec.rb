require 'spec_helper'

describe "Places" do
	it "if none are returned by the API, a correct notice is shown" do
		BeermappingApi.stub(:places_in).with("vantaa").and_return([])

		visit places_path
		fill_in('city', with: 'vantaa')
		click_button "Search"
		expect(page).to have_content "No locations in vantaa"
	end
	it "if one is returned by the API, it is shown at the page" do
		BeermappingApi.stub(:places_in).with("kumpula").and_return(
			[ Place.new(:name => "Oljenkorsi") ]
			)

		visit places_path
		fill_in('city', with: 'kumpula')
		click_button "Search"

		expect(page).to have_content "Oljenkorsi"
	end

	it "if more than one is returned by the API, all of them are shown" do
		BeermappingApi.stub(:places_in).with("olari").and_return(
			[ Place.new(:name => "Davisto"),
				Place.new(:name => "Janoinen Kameli"),
				Place.new(:name => "Kuutamo")]
				)
		visit places_path
		fill_in('city', with: 'olari')
		click_button "Search"
		expect(page).to have_content "Davisto"
		expect(page).to have_content "Janoinen Kameli"
		expect(page).to have_content "Kuutamo"
	end
end