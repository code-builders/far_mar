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

    a=CSV.read("support/vendors.csv")
    a.collect do |row|
    FarMar::Vendor.new(row)
    end

  end


# self.find(id) - returns the row where the ID field matches the argument
  def self.find(i)
    a=CSV.read("support/vendors.csv")
    row_match=a.find do |row|
    i == row[0].to_i
    end
    FarMar::Vendor.new(row_match)
  end



# market - returns the Market instance that is associated with this vendor using the Vendor market_id field
  def self.marketinstance(vendor_market_id)
      all.find do |x|

      end

  end

# need to connect the Vendor market_id field to the market instance in the other file









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


  # company_size
  # market - returns the Market instance that is associated with this vendor using the Vendor market_id field
  # products - returns a collection of Product instances that are associated with the vendor by the Product vendor_id field.
  # sales - returns a collection of Sale instances that are associated with the vendor by the Sale vendor_id field.





end
