require 'csv'

class FarMar::Product
  attr_accessor :id, :name, :vendor_id

  def initialize(attrs)
   @id= attrs[:id].to_i
   @name = attrs[:name]
   @vendor_id = attrs[:vendor_id].to_i
  end

  def self.all
    products = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/products.csv", "r")
    products.read.collect do |attrs|
      pdts = {
        id: attrs[0].to_i,
        name: attrs[1],
        vendor_id: attrs[2].to_i,
      }
      self.new(pdts)
      end
  end

  def self.find(id)
    id= id.to_i
    products = self.all
    products.find do |f|
     f.id.to_i == id.to_i
    end
  end

  def vendor
    vendors = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/vendors.csv", "r")
    all_vendors = vendors.read.collect do |attrs|
      vend = {
       id: attrs[0].to_i,
        name: attrs[1],
        no_of_employees: attrs[2].to_i,
        market_id: attrs[3].to_i
      }
    FarMar::Vendor.new(vend)
    end
    all_vendors.find_all do |f|
      f.id.to_i == self.vendor_id.to_i
    end
  end

  def sales
    sales = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/sales.csv", "r")
    all_sales = sales.read.collect do |attrs|
      sls = {
        id: attrs[0].to_i,
        amount: attrs[1].to_i,
        time_purchased: attrs[2],
        vendor_id: attrs[3].to_i,
        product_id: attrs[4].to_i,
        }
      FarMar::Sale.new(sls)
    end
    all_sales.find_all do |f|
      f.product_id.to_i == self.id.to_i
    end
  end

  def number_of_sales
    all_sales = self.sales
    times = []
    all_sales.find_all do |s|
      times << s.product_id
    end
    times.count
  end

  def self.by_vendor(vendor_id) #THIS DOES NOT WORK
    vend_products = self.all.group_by do |pdts|
      pdts.vendor_id
    end
    #vend_products[@name]
  end

    #g = all.find_all do |f|
    #f.vendor_id.to_i == vendor_id.to_i
    ##end
    #g[@name]




end



#number_of_sales - returns the number of times this product has been sold.
#self.by_vendor(vendor_id)- returns a list of all Product objects with a vendor id that matches the input
