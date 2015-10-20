# TO DO:
# - update initialize for integer methods - append with .to_i


require 'csv'

class FarMar::Market

  attr_accessor :id,
                :name,
                :address,
                :city,
                :county,
                :state,
                :zip

  def initialize (attrs)
    @id         = attrs[:id]
    @name       = attrs[:name]
    @address    = attrs[:address]
    @city       = attrs[:city]
    @county     = attrs[:county]
    @state      = attrs[:state]
    @zip        = attrs[:zip]
  end

### CLASS VARIABLES:
  @all_markets = CSV.open("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/markets.csv", "r")

  @attributes = @all_markets.map do |m| # will return array of hashes, each containing all info per market
    { id:       m[0],
      name:     m[1],
      address:  m[2],
      city:     m[3],
      county:   m[4],
      state:    m[5],
      zip:      m[6]
    }
  end

### SHARED CLASS METHODS
  # CLASS METHOD 1
  def self.all # returns array of 500 FarMar::Market objects, each of which contains hash of all CSV data
    all_markets_as_objects = @attributes.map do |m|
      FarMar::Market.new(m)
    end
  end

  # CLASS METHOD 2:
  def self.find (id)
    all_markets = self.all
    all_markets.find {|m| m.id.to_i == id.to_i}
  end

### UNIQUE CLASS METHODS:
  # vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.
  def self.vendors
    # TBD! Set up Vendors class first.
  end

  def self.find_by_state (state_name)
      all_markets = self.all
    all_markets.find {|m| m.state == state_name}

  end

  def self.find_all_by_state (state_name)
    all_markets = self.all
    all_markets.find_all {|m| m.state == state_name}
  end

end
