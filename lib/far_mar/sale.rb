## TO DO
# -refactor time formatting w/ .strftime for better readability
# -refactor self.between method for more user_friendly input (not assign variables, use Time.parse)

##COMMIT NOTES:
# -

require 'csv'

class FarMar::Sale

  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize (attrs)
    @id             = attrs[:id].to_i
    @amount         = attrs[:amount].to_i
    @purchase_time  = Time.parse(attrs[:purchase_time]) # => add .strftime later
    @vendor_id      = attrs[:vendor_id].to_i
    @product_id     = attrs[:product_id].to_i

  end

### SHARED CLASS METHODS
  def self.read_file
    all_sales = CSV.read("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/sales.csv", "r")

    attributes = all_sales.map do |s| # ret arr of hashes, each w/ all info per market
      { id:             s[0],
        amount:         s[1],
        purchase_time:  s[2],
        vendor_id:      s[3],
        product_id:     s[4],
      }
    end

  end

  def self.all
    self.read_file.map {|s| FarMar::Sale.new(s)}
  end

  def self.find (id)
    all.find {|s| s.id == id}
  end

### UNIQUE CLASS METHODS:
  def vendor # ret Vendor instance assoc w/ this sale via Sale vendor_id
    all_vendors = FarMar::Vendor.all
    match = all_vendors.find {|v| v.id == self.vendor_id}
  end

  def product # ret Product instance assoc w/ this sale via Sale product_id
    all_products = FarMar::Product.all
    match = all_products.find {|pr| pr.id == self.product_id}
  end

  def self.between(beginning_time, end_time) # ret all Sales where purchase time is bt 2 times given as arguments
    # may need to reformat b_t and e_t to make searching easier
    all_sales = self.all
    all_sales.find_all {|s| s.purchase_time >= beginning_time && s.purchase_time <= end_time}
  end

  def self.by_product(product_id) # => ret all sales of product X
    all_sales = self.all
    all_sales.find_all {|s| s.product_id == product_id}
  end

  def self.by_vendor(vendor_id) # ret all sales by vendor X
    all_sales = self.all
    all_sales.find_all {|s| s.vendor_id == vendor_id}
  end

end
