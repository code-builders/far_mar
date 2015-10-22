require 'csv'
require 'time'

class FarMar::Sale

  SALE_ARRAY = CSV.read("support/sales.csv")

  attr_reader :id,
              :amount,
              :purchase_time,
              :vendor_id,
              :product_id

    def initialize(attrs)
      @id               = attrs[:id].to_i
      @amount           = attrs[:amount].to_i
      @purchase_time    = Time.parse(attrs[:purchase_time])
      @vendor_id        = attrs[:vendor_id].to_i
      @product_id       = attrs[:product_id].to_i
    end

  def self.all
    # self.all - returns all rows of the CSV file as objects
    new_sale_array = []
    # reads sales.csv file
    # sale_array = CSV.read("support/sales.csv")
    SALE_ARRAY.each do |sale|
      # loop through all attributes of sale
      sale_info = {
        id:               sale[0],
        amount:           sale[1],
        purchase_time:    sale[2],
        vendor_id:        sale[3],
        product_id:       sale[4]
      }
      # create new sale object
      new_sale = FarMar::Sale.new(sale_info)
      # push each new sale object into one array called new_sale_array
      new_sale_array << new_sale
    end
    return new_sale_array
  end

  def self.find(id)
    # self.find(id) - returns the row where the ID field matches the argument
    # sale_array = CSV.read("support/sales.csv")
    SALE_ARRAY.each do |sale|
      sale_info = {
        id:               sale[0],
        amount:           sale[1],
        purchase_time:    sale[2],
        vendor_id:        sale[3],
        product_id:       sale[4]
      }
      if sale[0].to_i == id
        new_sale = FarMar::Sale.new(sale_info)
        return new_sale
      end
    end
  end

  def vendor
    # vendor - returns the Vendor instance that is associated with this sale using the Sale vendor_id field
    FarMar::Vendor.find(@vendor_id)

  end

  def product
    # product - returns the Product instance that is associated with this sale using the Sale product_id field
    FarMar::Product.find(@product_id)
  end

  def self.between(beginning_time, end_time)
    # self.between(beginning_time, end_time) - returns a collection of Sale objects where the purchase time is between the two times given as arguments
    all_sales = FarMar::Sale.all
    all_sales.find_all {|sale| sale.purchase_time > beginning_time && sale.purchase_time < end_time}
  end

  def self.by_product(product_id)
    # self.by_product(product_id) - returns an Array of Sale objects with a product_id matching the argument.
    all_sales = FarMar::Sale.all
    all_sales.find_all {|sale| sale.product_id == product_id}
  end

  def self.by_vendor(vendor_id)
    # self.by_vendor(vendor_id) - returns an Array of Sale objects with a vendor_id matching the argument.
    all_sales = FarMar::Sale.all
    all_sales.find_all {|sale| sale.vendor_id == vendor_id}
  end

end
