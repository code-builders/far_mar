# TO DO:
# -

# COMMIT NOTES:
# -

class FarMar::Vendor < FarMar::Base

  attr_accessor :id, :name, :no_of_employees, :market_id

  def initialize (attrs)
    @id               = attrs[:id].to_i
    @name             = attrs[:name]
    @no_of_employees  = attrs[:no_of_employees].to_i
    @market_id        = attrs[:market_id].to_i
  end

### SHARED CLASS METHODS
  def self.read_file
    all_vendors = CSV.open("support/vendors.csv", "r")

    attributes = all_vendors.map do |v| # ret arr of hashes, each w/ all info per vendor
      { id:              v[0],
        name:            v[1],
        no_of_employees: v[2],
        market_id:       v[3]
      }
    end
  end

  # here is where self.all and self.find(id) would go if we were to overwrite the
  # methods inherited from Base

### UNIQUE CLASS METHODS:
  def market # ret the Mkt instance assoc w/ vendor via Vendor market_id field
    all_markets = FarMar::Market.all
    match = all_markets.find {|m| m.id == self.market_id}
  end

  def products #ret Product instances assoc w/ vendor by the Product vendor_id field.
    all_products = FarMar::Product.all
    match = all_products.find_all {|p| p.vendor_id == self.id}
  end

  def sales #ret Sale instances assoc w/ vendor by vendor_id field.
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

  # GOAL: group vendor's sales grouped by hour and day. When do sales peak?
  def sales_by_hour
    sales_grouped = self.sales.group_by {|s| s.purchase_time.hour} # => all times of sale, in hash form
    sales_grouped.map {|h| h[1].size}
  end

  def sales_by_day
    sales_grouped = self.sales.group_by {|s| s.purchase_time.day} # => all dates of sale, in hash form
    sales_grouped.map {|h| h[1].size}
  end

end
