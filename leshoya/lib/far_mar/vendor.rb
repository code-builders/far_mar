#lib/far_mar/vendor.rb
require 'csv'

class FarMar::Vendor #capitalize all names of class
  attr_reader :id, :vendorname, :numberofemployees, :marketid

  def initialize(attrs)

      @id  =attrs[0].to_i
      @vendorname =attrs[1]
      @numberofemployees =attrs[2].to_i
      @marketid = attrs[3].to_i
  end

# self.find(id) - returns the row where the ID field matches the argument
  def self.all
    read_file.collect do |row|
    FarMar::Vendor.new(row)
    end
  end

# self.find(id) - returns the row where the ID field matches the argument
  def self.find(i)
    row_match=read_file.find do |row|
    i == row[0].to_i
    end
    FarMar::Vendor.new(row_match)
  end

# find a particular vendor by their name
  def self.find_by_name(name)
    all.find do |x|
    name == x.vendorname
    end
  end


# market - returns the Market instance that is associated with this vendor
#using the Vendor market_id field, is this right??? How to tell?
  def self.market(marketid)
    FarMar::Market.vendorcollection(marketid)
  end
#read file
#get list of vendors and search by vendor market_id
#match vendor market_id to market id

# products - returns a collection of Product instances that are associated with the vendor by the Product vendor_id field.
  def self.products(product_vendor_id)
      FarMar::Product.by_vendor(product_vendor_id)
  end

# sales - returns a collection of Sale instances that are associated with the vendor by the Sale vendor_id field.
  def self.sales(sale_vendor_id)
    FarMar::Sale.by_vendor(sale_vendor_id)
  end

  # revenue - returns the the sum of all of the vendor's sales (in cents)
  def revenue
##ONLY ONE I NEED TO WORK ON!!!!

  end


  def self.read_file
    CSV.read("support/vendors.csv")
  end

#self.by_market(market_id) - returns a list of all Vendor objects with a market id that matches the input
  def self.by_market(market_id)
      all.find_all do |x|
        market_id.to_i==x.marketid
        #provides the entire list of vendors associated with one market id
        # example: FarMar::Vendor.marketinstance(2)
      end
  end

  # company_size - returns the size of the company using the following rules:
  # 1-3 "Family Business"
  # 4-15 "Small Business"
  # 16-100 "Medium Business"
  # 101+ "Big Business"
  def self.company_size(company_size)
    all.find do |x|
    company_size==x.numberofemployees
    end
      if company_size <= 3 && company_size !=0
       "Family Business"
      elsif company_size >=4 && company_size <=15
       "Small Business"
      elsif company_size >=15 && company_size <=100
       "Medium Business"
      elsif company_size >=100
       "Big Business"
     end
  end




end
