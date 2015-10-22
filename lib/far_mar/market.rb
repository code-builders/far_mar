# TO DO:
# - 

# COMMIT NOTES:
# -

class FarMar::Market

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
    all_markets = CSV.read("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/markets.csv", "r")

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

  def self.all # returns array of 500 FarMar::Market objects, each of which contains hash of all CSV data
    self.read_file.map {|m| FarMar::Market.new(m)}

    # ****** Original code, same output but longer:
    # all_markets_as_objects = @attributes.map do |m|
    #   FarMar::Market.new(m)
    # end
    # ******
  end

  # CLASS METHOD 2: #ret instance of FarMar::Market matching id passed in
  def self.find (id)
    all.find {|m| m.id == id}

    # ****** Original code:
    # all_markets = self.all
    # all_markets.find {|m| m.id.to_i == id.to_i}
    # ******
  end

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
