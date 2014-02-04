require 'spec_helper'

describe Beer do
  it "is saved with proper name and style" do
  	beer = Beer.create name:"iso 3", style:"Lager"

  	expect(Beer.count).to be(1)
  	expect(beer).to be_valid
  end

  it "is not saved without a name" do
  	beer = Beer.create style:"Lager"

  	expect(beer).to_not be_valid
  	expect(Beer.count).to be(0)
  end

  it "is not saved without a style" do
  	beer = Beer.create name:"iso 3"

  	expect(beer).to_not be_valid
  	expect(Beer.count).to be(0)
  end
end
