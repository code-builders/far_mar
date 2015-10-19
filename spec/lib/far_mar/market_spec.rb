require 'spec_helper'
describe FarMar::Market do
  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Market).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Market.all.count).to eq 500
    end

    it "responds to 'find'" do
      expect(FarMar::Market).to respond_to :find
    end

    it "find the first market by market 1" do
      expect(FarMar::Market.find(100).name).to eq "Klamath Falls Farmers Market"
    end
  end

  describe "attributes" do
    let(:market) { FarMar::Market.find(10) }
    # 10,Saratoga Farmers' Market,1 Bayberry Drive,Ballston Sp,Saratoga,New York,12020

    it "has the id 10" do
      expect(market.id).to eq 10
    end
    it "has the name" do
      expect(market.name).to eq "Saratoga Farmers' Market"
    end
  end

  describe "associations" do
    let(:market) { FarMar::Market.find(1) }
    # 10,Saratoga Farmers' Market,1 Bayberry Drive,Ballston Sp,Saratoga,New York,12020

    it "responds to :vendors" do
      expect(market).to respond_to :vendors
    end

    it "market_id matches the markets id" do
      expect(market.vendors.count).to eq 6
    end

  end
end
