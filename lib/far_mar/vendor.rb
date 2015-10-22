# TO DO:
# - DRY: add .read_file class method, refactor .all, .find to use .read_file
# - refactor .market method - seems like it could be shorter

# COMMIT NOTES:
# - .revenue method for Vendor class, fixed @amount attr for Sale class to integer, cleaned up debug notes

require 'csv'

class FarMar::Vendor

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
  def self.all # ret array of 2690 FM::Vendor objects, each containing hash of CSV data
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
  def market # ret Mkt instance assoc w/ vendor via Vendor market_id field
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

  def revenue #ret sum of all vendor's sales (in cents)
    all_sales_array = self.sales.map {|s| s.amount}
    all_sales_array.inject{|sum,x| sum + x }
  end

  def self.by_market(market_id) # ret all Vendors within a market, via market id
    all_vendors = self.all
    all_vendors.find_all {|v| v.market_id.to_i == market_id}
  end

  def company_size
    e = self.no_of_employees
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
