require 'spec_helper'

describe Beer do

  before :each do 
    Style.create name:"Lager", description:"lager is good"
  end
  it "is saved with proper name and style" do
  	beer = Beer.create name:"iso 3", style_id:1

  	expect(Beer.count).to be(1)
  	expect(beer).to be_valid
  end

  it "is not saved without a name" do
  	beer = Beer.create style_id:1

  	expect(beer).to_not be_valid
  	expect(Beer.count).to be(0)
  end

  it "is not saved without a style" do
  	beer = Beer.create name:"iso 3"

  	expect(beer).to_not be_valid
  	expect(Beer.count).to be(0)
  end
end
