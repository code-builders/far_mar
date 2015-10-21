#lib/far_mar/vendor.rb
require 'csv'

class FarMar::Vendor #capitalize all names of class
  attr_reader
    :id
    :vendorname
    :numberofemployees
    :marketid

  def initialize(attrs)

      @id  =attrs[:id]
      @vendorname =attrs[:vendorname]
      @numberofemployees =attrs[:numberofemployees]
      @marketid = attrs[:marketid]

  end

  def self.all
    new_vendor_object= []
    a=CSV.read("support/vendors.csv")#read the CSV file
    a.each do |row|
  #
  #
      row_info = {
        id:row[0].to_i,
        vendorname: row[1],
        numberofemployees: row[2],
        marketid: row[3]

      }

      new_vendor = FarMar::Vendor.new(row_info)
      new_vendor_object<< new_vendor
      end
  #     # new_vendor_array
  end

  def self.find(id)
    new_vendor_object= []
    a=CSV.read("support/vendors.csv")#read the CSV file
    a.each do |row|
  #
  #
      row_info = {
        id:row[0].to_i,
        vendorname: row[1],
        numberofemployees: row[2],
        marketid: row[3]

      }

      if row[0].to_i == id
        newvendor = FarMar::Vendor.new(row_info)
        new_vendor_object << newvendor
        end

    end
    new_vendor_object #returns the specific object
  end





end
