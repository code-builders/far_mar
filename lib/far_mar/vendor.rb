require 'csv'

class FarMar::Vendor

  attr_reader :id,
              :name,
              :no_of_employees,
              :market_id

    def initialize(attrs)
      @id               = attrs[:id]
      @name             = attrs[:name]
      @no_of_employees  = attrs[:no_of_employees]
      @market_id        = attrs[:market_id]
    end

  def self.all
    # self.all - returns all rows of the CSV file as objects
    new_vendor_array = []
    # reads vendors.csv file
    vendor_array = CSV.read("support/vendors.csv")
    vendor_array.each do |vendor|
      # loop through all attributes of market
      vendor_info = {
        id:               vendor[0].to_i,
        name:             vendor[1],
        no_of_employees:  vendor[2].to_i,
        market_id:        vendor[3].to_i
      }
      # create new vendor object
      new_vendor = FarMar::Vendor.new(vendor_info)
      # push each new vendor object into one array called new_vendor_array
      new_vendor_array << new_vendor
    end
    return new_vendor_array
  end

  def self.find(id)
    # self.find(id) - returns the row where the ID field matches the argument
    vendor_array = CSV.read("support/vendors.csv")
    vendor_array.each do |vendor|
      vendor_info = {
        id:               vendor[0].to_i,
        name:             vendor[1],
        no_of_employees:  vendor[2].to_i,
        market_id:        vendor[3].to_i
      }
      if vendor[0].to_i == id
        new_vendor = FarMar::Vendor.new(vendor_info)
        return new_vendor
      end
    end
  end

  def market
  # market - returns the Market instance that is associated with this vendor using the Vendor market_id field
    #FarMar::Market.find finds the market instance using the market_id
    FarMar::Market.find(@market_id)
  end

  def products
  # products - returns a collection of Product instances that are associated with market by the Product vendor_id field.

  end

  def sales
  # sales - returns a collection of Sale instances that are associated with market by the vendor_id field.

  end

  def revenue
  # revenue - returns the the sum of all of the vendor's sales (in cents)

  end

  def self.by_market(market_id)
  # self.by_market(market_id) - returns a list of all Vendor objects with a market id that matches the input

  end

  def company_size
  # company_size - returns the size of the company using the following rules:
  # 1-3 "Family Business"
  # 4-15 "Small Business"
  # 16-100 "Medium Business"
  # 101+ "Big Business"

  end

end
