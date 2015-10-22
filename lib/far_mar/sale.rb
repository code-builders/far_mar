require 'csv'

class FarMar::Sale
  attr_accessor :id, :amount, :time_purchased, :vendor_id, :product_id

  def initialize(attrs)
    @id             = attrs[0].to_i
    @amount         = attrs[1].to_i
    @time_purchased = attrs[2]
    @vendor_id      = attrs[3].to_i
    @product_id     = attrs[4].to_i
  end

    def self.all
      sales = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/sales.csv", "r")
      sales.read.collect do |attrs|
        self.new(attrs)
      end
    end

    def self.find(id)
      id= id.to_i
      sales = self.all
      sales.find do |f|
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

    def product
      products = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/products.csv", "r")
      all_products = products.read.collect do |attrs|
        pdts = {
          id: attrs[0].to_i,
          name: attrs[1],
          vendor_id: attrs[2].to_i
        }
        FarMar::Product.new(pdts)
      end
      all_products.find_all do |f|
        f.id.to_i == self.product_id.to_i
      end
    end

    def self.by_product(product_id)
      all.find_all do |f|
        f.product_id.to_i == product_id.to_i
      end
    end

    def self.by_vendor(vendor_id)
      all.find_all do |f|
        f.vendor_id.to_i == vendor_id.to_i
      end
    end

#self.between(beginning_time, end_time) - returns a collection of Sale objects where the purchase time is between the two times given as arguments

end
