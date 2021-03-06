require 'csv'

class FarMar::Vendor < FarMar::Base

  VENDOR_ARRAY = CSV.read("support/vendors.csv")

  attr_reader :name,
              :no_of_employees,
              :market_id

    def initialize(attrs)
      super(attrs[:id])
      @name             = attrs[:name]
      @no_of_employees  = attrs[:no_of_employees].to_i
      @market_id        = attrs[:market_id].to_i
    end

  def self.all
    # self.all - returns all rows of the CSV file as objects
    new_vendor_array = []
    # reads vendors.csv file
    # vendor_array = CSV.read("support/vendors.csv")
    VENDOR_ARRAY.each do |vendor|
      # loop through all attributes of market
      vendor_info = {
        id:               vendor[0],
        name:             vendor[1],
        no_of_employees:  vendor[2],
        market_id:        vendor[3]
      }
      # create new vendor object
      new_vendor = FarMar::Vendor.new(vendor_info)
      # push each new vendor object into one array called new_vendor_array
      new_vendor_array << new_vendor
    end
    return new_vendor_array
  end

  # def self.find(id)
  #   # self.find(id) - returns the row where the ID field matches the argument
  #   # vendor_array = CSV.read("support/vendors.csv")
  #   # self.all.find {|object| object.id == id}
  # #   VENDOR_ARRAY.each do |vendor|
  # #     vendor_info = {
  # #       id:               vendor[0],
  # #       name:             vendor[1],
  # #       no_of_employees:  vendor[2],
  # #       market_id:        vendor[3]
  # #     }
  # #     if vendor[0].to_i == id
  # #       new_vendor = FarMar::Vendor.new(vendor_info)
  # #       return new_vendor
  # #     end
  # #   end
  # end

  def market
  # market - returns the Market instance that is associated with this vendor using the Vendor market_id field
    #FarMar::Market.find finds the market instance using the market_id
    FarMar::Market.find(@market_id)
  end

  def products
  # products - returns a collection of Product instances that are associated with vendor by the Product vendor_id field.
    # returns array of product instances
    # product_instances = []
    product_array = FarMar::Product.all
    product_array.find_all {|product| product.vendor_id == @id}
    #   if product.vendor_id == @id
    #     product_instances << product
    #   end
    # end
    # return product_instances
  end

  def sales
  # sales - returns a collection of Sale instances that are associated with vendor by the vendor_id field.
    # sale_instances = []
    sale_array = FarMar::Sale.all
    sale_array.find_all {|sale| sale.vendor_id == @id}
    #   if sale.vendor_id == @id
    #     sale_instances << sale
    #   end
    # end
    # return sale_instances
  end

  def revenue
  # revenue - returns the the sum of all of the vendor's sales (in cents)
    sale_instances = sales
    total_cost = 0
    sale_instances.each do |cost|
      total_cost += cost.amount
    end
    return total_cost
  end

  def self.by_market(market_id)
  # self.by_market(market_id) - returns a list of all Vendor objects with a market id that matches the input
    # vendor_array = []
    all_vendors = FarMar::Vendor.all
    all_vendors.find_all {|vendor| vendor.market_id == market_id}
    #   if vendor.market_id == market_id
    #     vendor_array << vendor
    #   end
    # end
    # return vendor_array
  end

  def company_size
  # company_size - returns the size of the company using the following rules:
  # 1-3 "Family Business"
  # 4-15 "Small Business"
  # 16-100 "Medium Business"
  # 101+ "Big Business"
    if @no_of_employees >= 1 && @no_of_employees <= 3
      #or can do if (1..3) === @no_of_employees
      return "Family Business"
    elsif @no_of_employees >= 4 && @no_of_employees <= 15
      return "Small Business"
    elsif @no_of_employees >= 16 && @no_of_employees <= 100
      return "Medium Business"
    else
      return "Big Business"
    end
  end

  # def self.seller_by_product(product_name)
  #   vendor_list = []
  #   self.all.each do |vendor|
  #     vendor.products.each do |product|
  #       if product.name.downcase.include? product_name.downcase
  #         vendor_list << vendor
  #         break
  #       end
  #     end
  #   end
  #   return vendor_list
  # end

  def self.seller_by_product(product_name)
    vendor_list = []
    FarMar::Product.find_by_product(product_name).each do |product|
      vendor_list << product.vendor
    end
    return vendor_list
  end
  
end
