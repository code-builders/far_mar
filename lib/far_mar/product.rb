require 'csv'
#
class FarMar::Product

  attr_reader :id, :name, :vendorid

  def initialize(attrs)

    @id =attrs[0].to_i
    @name =attrs[1]
    @vendorid =attrs[2].to_i
  end

# self.all - returns all rows of the CSV file as objects
  def self.all
    read_file.collect do |row|
    FarMar::Product.new(row)
    end
  end

# self.find(id) - returns the row where the ID field matches the argument
  def self.find(id)
    row_match=read_file.find do |row|
    id.to_i== row[0].to_i
    end
    FarMar::Product.new(row_match)
  end

#READ FILE METHOD
  def self.read_file
    CSV.read("support/products.csv")
  end

# self.by_vendor(vendor_id)- returns a list of all Product objects with a vendor id that matches the input

  def self.by_vendor(vendor_id)
    all.find_all do |x|
    vendor_id.to_i==x.vendorid
    end
  end


  # # vendor - returns the Vendor instance that is associated with this vendor using the Product vendor_id field
  def self.vendor(vendorid)
    FarMar::Vendor.find(vendorid)
  end


  # sales - returns a collection of Sale instances that are associated with the product using the Sale product_id field.
  def self.sales(product_id)
    FarMar::Sale.by_product(product_id)
  end
#
# # number_of_sales - returns the number of times this product has been sold.#ONLY ONE I NEED
# #
  # def number_of_sales
  #   FarMar::Sale.by_product(productid).count
  # end

end
#
