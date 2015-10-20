# TO DO:
# -

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


  # products - returns a collection of Product instances that are associated with market by the Product vendor_id field.


  # sales - returns a collection of Sale instances that are associated with market by the vendor_id field.


  # revenue - returns the the sum of all of the vendor's sales (in cents)


  # self.by_market(market_id) - returns a list of all Vendor objects with a market id that matches the input


  # company_size - returns the size of the company using the following rules:
    # 1-3 "Family Business"
    # 4-15 "Small Business"
    # 16-100 "Medium Business"
    # 101+ "Big Business"

end
