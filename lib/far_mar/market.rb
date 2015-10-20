
require 'csv'

class FarMar::Market
  attr_accessor :id, :name, :address, :city, :county, :state, :zip

  def initialize(attrs)
   @id= attrs[:id].to_i
   @name = attrs[:name]
   @address = attrs[:address]
   @city = attrs[:city]
   @county = attrs[:county]
   @state = attrs[:state]
   @zip = attrs[:zip]
  end

  def self.all
    markets = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/markets.csv", "r")
    markets.read.collect do |attrs|
      mkts = {
        id: attrs[0].to_i,
        name: attrs[1],
        address: attrs[2],
        city: attrs[3],
        county: attrs[4],
        state: attrs[5],
        zip: attrs[6]
      }
      m = FarMar::Market.new(mkts)
    end
  end

  def self.find(id)
    id= id.to_i
    markets = self.all
    markets.find do |f|
      f.id.to_i == id.to_i
    end
  end

  def vendors
    vendors = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/vendors.csv", "r")
    all_vendors = vendors.read.collect do |attrs|
      vend = {
        id: attrs[0],
        name: attrs[1],
        num_employees: attrs[2],
        market_id: attrs[3]
      }
     v = FarMar::Vendor.new(vend)
    end
    all_vendors.find_all do |f|
      f.market_id.to_i == self.id.to_i
    end
  end


  def self.find_by_state_name(state_name)
    state_name = state_name.to_s
    markets =  self.all
    markets.find do |f|
      f.state == state_name
    end
  end

  def self.find_all_by_state_name(state_name)
    state_name = state_name.to_s
    markets =  self.all
    markets.find_all do |f|
      f.state == state_name
    end
  end






#find_by_state(state_name) - Returns the first Market object with a state name which matches the input


  #  )
  #set attr _accessors for the class
  #read csv file and separate each row
  #initialize each instance of the market requiring hash of attrs
  #define instance viariablesin all class
  #each row of the CSV is a market instance
  #from each row, we need to define the 7 attributes that come from the columns in the CSV
end
