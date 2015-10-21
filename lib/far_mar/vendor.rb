#lib/far_mar/vendor.rb
require 'csv'

class FarMar::Vendor #capitalize all names of class
  attr_reader
    :id
    :vendorname
    :numberofemployees
    :marketid

  def initialize(attrs)

      @id  =attrs[0].to_i
      @vendorname =attrs[1]
      @numberofemployees =attrs[2]
      @marketid = attrs[3]

  end

  def self.all

    a=CSV.read("support/vendors.csv")
    a.collect do |row|
    FarMar::Vendor.new(row)
    end

  end

  def self.find(i)
    a=CSV.read("support/vendors.csv")
    row_match=a.find do |row|
    i == row[0].to_i
    end
    FarMar::Vendor.new(row_match)
  end


end
  
