## TO DO
# -make sure formatting (.to_i, .to_f, etc.) is correct in initialize

require 'csv'

class FarMar::Sale

  # Each sale belongs to a vendor AND an product, the vendor_id and product_id
  # fields relates to the Vendor and Product ID fields

  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize (attrs)
    @id             = attrs[:id].to_i
    @amount         = attrs[:amount].to_f # + /100 to end? needs to be in cents
    @purchase_time  = attrs[:purchase_time] # not sure how to format
    @vendor_id      = attrs[:vendor_id].to_i
    @product_id     = attrs[:product_id].to_i

  end

### SHARED CLASS METHODS
  def self.read_file
    all_sales = CSV.read("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/sales.csv", "r")

    attributes = all_sales.map do |s| # will return array of hashes, each containing all info per market
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

  # vendor - returns the Vendor instance that is associated with this sale using the Sale vendor_id field


  # product - returns the Product instance that is associated with this sale using the Sale product_id field


  # self.between(beginning_time, end_time) - returns a collection of Sale objects where the purchase time is between the two times given as arguments


  # self.by_product(product_id) - returns an Array of Sale objects with a product_id matching the argument.


  # self.by_vendor(vendor_id) - returns an Array of Sale objects with a vendor_id matching the argument.




end
