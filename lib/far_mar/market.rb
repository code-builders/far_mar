# TO DO:
# -

# COMMIT NOTES:
# -

class FarMar::Market < FarMar::Base
  attr_accessor :id, :name, :address, :city, :county, :state, :zip

  def initialize (attrs)
    @id         = attrs[:id].to_i
    @name       = attrs[:name]
    @address    = attrs[:address]
    @city       = attrs[:city]
    @county     = attrs[:county]
    @state      = attrs[:state]
    @zip        = attrs[:zip]
  end

### SHARED CLASS METHODS
  # CLASS METHOD 1
  def self.read_file
    all_markets = CSV.read("support/markets.csv", "r")

    attributes = all_markets.map do |m| # will return array of hashes, each containing all info per market
      { id:       m[0],
        name:     m[1],
        address:  m[2],
        city:     m[3],
        county:   m[4],
        state:    m[5],
        zip:      m[6]
      }
    end
  end

  # here is where self.all and self.find(id) would go if we were to overwrite the
  # methods inherited from Base

### UNIQUE CLASS METHODS:
  def vendors # ret all Vendor instances associated with market by market_id
    all_vendors = FarMar::Vendor.all
    match = all_vendors.find_all {|v| v.market_id == self.id}
  end

  def self.find_by_state (state_name) # ret first market object in state passed in
    self.all.find {|m| m.state == state_name}
  end

  def self.find_all_by_state (state_name) # ret all market objects in state passed in
    self.all.find_all {|m| m.state == state_name}
  end

end
