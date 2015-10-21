require 'csv'

class FarMar::Sale

  attr_reader :id,
              :amount_in_cents,
              :purchase_time,
              :vendor_id,
              :product_id

    def initialize(attrs)
      @id               = attrs[:id]
      @amount_in_cents  = attrs[:amount_in_cents]
      @purchase_time    = attrs[:purchase_time]
      @vendor_id        = attrs[:vendor_id]
      @product_id       = attrs[:product_id]
    end

  def self.all
    # self.all - returns all rows of the CSV file as objects
    new_sale_array = []
    # reads sales.csv file
    sale_array = CSV.read("support/sales.csv")
    sale_array.each do |sale|
      # loop through all attributes of sale
      sale_info = {
        id:               sale[0].to_i,
        amount_in_cents:  sale[1].to_i,
        purchase_time:    sale[2],
        vendor_id:        sale[3].to_i,
        product_id:       sale[4].to_i
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
    sale_array = CSV.read("support/sales.csv")
    sale_array.each do |sale|
      sale_info = {
        id:               sale[0].to_i,
        amount_in_cents:  sale[1].to_i,
        purchase_time:    sale[2],
        vendor_id:        sale[3].to_i,
        product_id:       sale[4].to_i
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

  def self. between(beginning_time, end_time)
    # self.between(beginning_time, end_time) - returns a collection of Sale objects where the purchase time is between the two times given as arguments

  end

  def self.by_product(product_id)
    # self.by_product(product_id) - returns an Array of Sale objects with a product_id matching the argument.

  end

  def self.by_vendor(vendor_id)
    # self.by_vendor(vendor_id) - returns an Array of Sale objects with a vendor_id matching the argument.

  end

end
