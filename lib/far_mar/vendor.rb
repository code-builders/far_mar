# TO DO:
# - clarify self.by_market method with BW. What should it return?

# COMMIT NOTES:
# - added

require 'csv'

class FarMar::Vendor

  # Each vendor belongs to a market, the market_id field relates to the
  # Market ID field. Each vendor has many products they sell.

  attr_accessor :id, :name, :employees, :market_id

  def initialize (attrs)
    @id         = attrs[:id]
    @name       = attrs[:name]
    @employees  = attrs[:employees]
    @market_id  = attrs[:market_id]
  end

### CLASS VARIABLES:
  @all_vendors = CSV.open("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/vendors.csv", "r")

  @attributes = @all_vendors.map do |v| # will return array of hashes, each containing all info per vendor
    { id:        v[0],
      name:      v[1],
      employees: v[2],
      market_id: v[3]
    }
  end

### SHARED CLASS METHODS
  # CLASS METHOD 1
  def self.all # returns array of #2690 FarMar::Vendor objects, each of which contains hash of all CSV data
    all_vendors_as_objects = @attributes.map do |v|
      FarMar::Vendor.new(v)
    end
  end

  # CLASS METHOD 2:
  def self.find (id)
    all_vendors = self.all
    all_vendors.find {|v| v.id.to_i == id.to_i}
  end


### UNIQUE CLASS METHODS:
  # market - returns the Market instance that is associated with this vendor using the Vendor market_id field
  def market
    v = self                          # => self = instance of Vendor class
    @i = v.market_id                  # => mkt id of Vendor instance
    all_markets = FarMar::Market.all  # => all Market objects
    match = all_markets.find {|m| m.id == @i} # => id of Market object matches mkt_id of Vendor
  end

  # products - returns a collection of Product instances that are associated with market by the Product vendor_id field.
  def products
    # TBD! Set up Product class first.
  end

  # sales - returns a collection of Sale instances that are associated with market by the vendor_id field.
  def sale
    # TBD! Set up Sale class first
  end

  # revenue - returns the the sum of all of the vendor's sales (in cents)
  def revenue #don't think this needs .self -- it's an instance method b/c on specific vendor instance
    # TBD! Set up Sale (or Product?) class first
  end

  # self.by_market(market_id) - returns a list of all Vendor objects with a market id that matches the input
  ## What does BW mean here? only one vendor object will result from this search, so not sure what 'all vendor objects' means
  def self.by_market(market_id)
    all_vendors = self.all
    all_vendors.find_all {|v| v.market_id.to_i == market_id}
  end

  def company_size # can only call this on instance created by `sample = FM::V.by_market(`mkt_id`)`. will this do?
    e = self.employees.to_i

    if    e >= 1  && e <= 3
      puts "Family Business"
    elsif e >= 4  && e <= 15
      puts "Small Businesss"
    elsif e >= 16 && e <= 100
      puts "Medium Business"
    elsif e > 101
      puts "Big Business"
    end

  end

end
