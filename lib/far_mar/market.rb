require 'csv'

class FarMar::Market

  attr_reader :id,
              :name,
              :address,
              :city,
              :county,
              :state,
              :zip

    def initialize(attrs)
      @id      = attrs[:id]
      @name    = attrs[:name]
      @address = attrs[:address]
      @city    = attrs[:city]
      @county  = attrs[:county]
      @state   = attrs[:state]
      @zip     = attrs[:zip]
    end

  def self.all
    # self.all - returns all rows of the CSV file as objects
    new_market_array = []
    # reads markets.csv file
    market_array = CSV.read("support/markets.csv")
    market_array.each do |market|
      # loop through all attributes of market
      market_info = {
        id:      market[0].to_i,
        name:    market[1],
        address: market[2],
        city:    market[3],
        county:  market[4],
        state:   market[5],
        zip:     market[6]
      }
      # create new market object
      new_market = FarMar::Market.new(market_info)
      # push each new market object into one array called new_market_array
      new_market_array << new_market
    end
    return new_market_array
  end

  def self.find(id)
    # self.find(id) - returns the row where the ID field matches the argument
    market_array = CSV.read("support/markets.csv")
    market_array.each do |market|
      market_info = {
        id:      market[0].to_i,
        name:    market[1],
        address: market[2],
        city:    market[3],
        county:  market[4],
        state:   market[5],
        zip:     market[6]
      }
      if market[0].to_i == id
        new_market = FarMar::Market.new(market_info)
        return new_market
      end
    end
  end

  def vendors
    # vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.
    vendor_objects = []
    all_vendors = FarMar::Vendor.all
    all_vendors.each do |vendor|
      if vendor.market_id == @id
        vendor_objects << vendor
      end
    end
    return vendor_objects
  end

  def self.find_by_state(state_name)
    # find_by_state(state_name) - Returns the first Market object with a state name which matches the input
    all_markets = FarMar::Market.all
    all_markets.find {|market| market.state == state_name.capitalize}
  end

  def self.find_all_by_state(state_name)
    # find_by_state(state_name) - Returns a list of all Market objects with a state name that matches the input
    all_markets = FarMar::Market.all
    return all_markets.find_all {|market| market.state == state_name.capitalize}
  end
end
