# TO DO:
# - get .revenue method working
# - clarify self.by_market method with BW. What should it return?
# - DRY: add .read_file class method, refactor .all, .find to use .read_file

# COMMIT NOTES:
# -

require 'csv'

class FarMar::Vendor

  # Each vendor belongs to a market, the market_id field relates to the
  # Market ID field. Each vendor has many products they sell.

  attr_accessor :id, :name, :no_of_employees, :market_id

  def initialize (attrs)
    @id               = attrs[:id].to_i
    @name             = attrs[:name]
    @no_of_employees  = attrs[:no_of_employees].to_i
    @market_id        = attrs[:market_id].to_i
  end

### CLASS VARIABLES:
  @all_vendors = CSV.open("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/vendors.csv", "r")

  @attributes = @all_vendors.map do |v| # will return array of hashes, each containing all info per vendor
    { id:              v[0],
      name:            v[1],
      no_of_employees: v[2],
      market_id:       v[3]
    }
  end

### SHARED CLASS METHODS
  # DRY: Add self.read_file method here

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

  def products #ret. Product instances assoc w/ vendor by the Product vendor_id field.
    all_products = FarMar::Product.all
    match = all_products.find_all {|p| p.vendor_id == self.id}
  end


  def sales #ret. Sale instances assoc w/ vendor by vendor_id field.
    all_sales = FarMar::Sale.all
    match = all_sales.find_all {|s| s.vendor_id == self.id}
  end

  #don't think this needs .self in method name-- it's an instance method b/c on specific vendor instance
  def revenue #ret sum of all vendor's sales (in cents)
    # puts "self when this far into .revenue method:"
    # puts self.class # => FM::Vendor
    # all_sales = []
    # sum = []
    # self.sales.each {|s| all_sales << s.amount} # => here, self is this instance of Vendor
    # sum = all_sales.each {|a| sum += a}
    # puts sum

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
