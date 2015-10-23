#lib/far_mar/sale.rb
require 'csv'

class FarMar::Sale #capitalize all names of class

  attr_reader :id, :saleamount, :purchasetime, :vendorid, :productid

    def initialize(attrs)
      @id= attrs[0].to_i
      @saleamount=attrs[1]
      @purchasetime=attrs[2]
      @vendorid=attrs[3].to_i
      @productid=attrs[4].to_i

    end

# self.all - returns all rows of the CSV file as objects
    def self.all
      read_file.collect do |row|
      FarMar::Sale.new(row)
      end
    end
#
# self.find(id) - returns the row where the ID field matches the argument
    def self.find(id)
      read_file.find do |row|
      id == row[0].to_i
      end
    end

#Method that reads the file
    def self.read_file
      CSV.read("support/sales.csv")
    end

# self.by_vendor(vendor_id) - returns an Array of Sale objects with a vendor_id matching the argument.
  def self.by_vendor(vendor_id)
    all.find_all do |x|
    vendor_id.to_i==x.vendorid
    end
  end

# self.by_product(product_id)` - returns an `Array` of `Sale` objects with a `product_id` matching the argument.
    def self.by_product(product_id)
      all.find_all do |x|
      product_id.to_i==x.productid
    end

    end






end
