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
    self.all.find do |f|
      f.id == id
    end
  end

  def vendor
    vendors = FarMar::Vendor.all
    all_vendors = vendors.group_by do |obj|
      obj.id
    end
    all_vendors[@vendor_id].first
  end

  def product
    products = FarMar::Product.all
    all_products = products.group_by do |obj|
      obj.id
    end
    all_products[@product_id].first
  end

  def self.by_product(product_id)
    all_sale = self.all.group_by do |obj|
      obj.product_id
    end
    all_sale[product_id]
  end


  def self.by_vendor(vendor_id)
    all_sale = self.all.group_by do |obj|
      obj.vendor_id
    end
    all_sale[vendor_id]
  end


#self.between(beginning_time, end_time) - returns a collection of Sale objects where the purchase time is between the two times given as arguments

end
