## TO DO
# -

require 'csv'

class FarMar::Product
  # Each product belongs to a vendor, the vendor_id field relates to the Vendor ID field.

  attr_accessor :id, :name, :vendor_id

  def initialize (attrs)
    @id        = attrs[:id].to_i
    @name      = attrs[:name]
    @vendor_id = attrs[:vendor_id].to_i
  end

### SHARED CLASS METHODS
  def self.read_file
    all_products = CSV.read("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/products.csv", "r")

    attributes = all_products.map do |pr| # will return array of hashes, each containing all info per market
      { id:       pr[0],
        name:     pr[1],
        vendor_id:pr[2]
      }
    end
  end

  def self.all
    self.read_file.map {|pr| FarMar::Product.new(pr)}
  end

  def self.find (id)
    all.find {|pr| pr.id == id}
  end

### UNIQUE CLASS METHODS:

  # vendor - returns the Vendor instance that is associated with this vendor using the Product vendor_id field


  # sales - returns a collection of Sale instances that are associated with market using the Sale product_id field.


  # number_of_sales - returns the number of times this product has been sold.


  # self.by_vendor(vendor_id)- returns a list of all Product objects with a vendor id that matches the input



end
