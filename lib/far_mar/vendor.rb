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
    # reads markets.csv file
    vendor_array = CSV.read("support/vendors.csv")
    vendor_array.each do |vendor|
      # loop through all attributes of market
      vendor_info = {
        id:               vendor[0].to_i,
        name:             vendor[1],
        no_of_employees:  vendor[2].to_i,
        market_id:        vendor[3].to_i
      }
      # create new market object
      new_vendor = FarMar::Vendor.new(vendor_info)
      # push each new market object into one array called new_market_array
      new_vendor_array << new_vendor
    end
    new_vendor_array
  end

  def self.find(id)
    # self.find(id) - returns the row where the ID field matches the argument
    new_vendor_object = []
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
        new_vendor_object << new_vendor
      end
    end
    new_vendor_object[0]
  end

  # def  vendors()
  #
  #   # vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.
  #
  # end
  #
  # def find_by_state(state_name)
  #
  #   # find_by_state(state_name) - Returns the first Market object with a state name which matches the input
  #
  # end
  #
  # def find_by_state(state_name)
  #
  #   # find_by_state(state_name) - Returns a list of all Market objects with a state name that matches the input
  #
  # end
end
