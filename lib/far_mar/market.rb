require 'csv'

class FarMar::Market < FarMar::Base

  MARKET_ARRAY = CSV.read("support/markets.csv")

  attr_reader :name,
              :address,
              :city,
              :county,
              :state,
              :zip

    def initialize(attrs)
      super(attrs[:id])           # @id = attrs[0].to_i
      @name    = attrs[:name]     # @name = attrs[1]
      @address = attrs[:address]  # @address = attrs[2]
      @city    = attrs[:city]     # @city = attrs[3]
      @county  = attrs[:county]   # @county = attrs[4]
      @state   = attrs[:state]    # @state = attrs[5]
      @zip     = attrs[:zip]      # @zip = attrs[6]
    end

  def self.all
    # self.all - returns all rows of the CSV file as objects
    new_market_array = []
    # reads markets.csv file
    # market_array = CSV.read("support/markets.csv")  # market_array = (self)read_file
    MARKET_ARRAY.each do |market|  # can also do market_array.collect do |row|
      # loop through all attributes of market
      market_info = {              # FarMar::Market.new(row)
        id:      market[0],
        name:    market[1],
        address: market[2],           # read_file.collect do |row| OR
        city:    market[3],           # market_array.collect do |row|
        county:  market[4],             # FarMar::Market.new(row)
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

  # def self.find(id)
  #   # self.find(id) - returns the row where the ID field matches the argument
  #   # market_array = CSV.read("support/markets.csv") # market_array = (self)read_file
  #   # self.all.find {|object| object.id == id}
  #   super
  # end

  def vendors
    # vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.
    # vendor_objects = []
    all_vendors = FarMar::Vendor.all  #can also do FarMar::Vendor.all.find_all {|vendor| vendor.market_id == @id}
    all_vendors.find_all {|vendor| vendor.market_id == @id}
      # if vendor.market_id == @id
      #   vendor_objects << vendor
      # end
    # return vendor_objects
  end

  def self.find_by_state(state_name)
    # find_by_state(state_name) - Returns the first Market object with a state name which matches the input
    all_markets = FarMar::Market.all
    all_markets.find {|market| market.state == state_name.capitalize}
  end

  def self.find_all_by_state(state_name)
    # find_by_state(state_name) - Returns a list of all Market objects with a state name that matches the input
    all_markets = FarMar::Market.all
    all_markets.find_all {|market| market.state == state_name.capitalize}
  end

  # def self.find_by_product(product_name)
  #   # all_markets = self.all
  #   # all_vendors = FarMar::Vendor.all
  #   all_products = FarMar::Product.all
  #     if all_products.include? product_name.capitalize
  #       FarMar::Vendor.


      # end
  # end
end
