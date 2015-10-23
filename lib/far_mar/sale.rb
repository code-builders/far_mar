require 'csv'

class FarMar::Sale
  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize(attrs)
    require 'time'
    @id             = attrs[0].to_i
    @amount         = attrs[1].to_i
    @purchase_time  = Time.parse(attrs[2])
    @vendor_id      = attrs[3].to_i
    @product_id     = attrs[4].to_i
  end

  def self.all
    sales = CSV.read("/Users/khambro/CodeBuilders/far_mar/support/sales.csv")
    sales.collect do |attrs|
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

  def self.between(beginning_time, end_time)
    require 'time'
    sales_within_block = []
     self.all.group_by do |obj|
        obj.purchase_time
      if obj.purchase_time.between?(Time.parse(beginning_time), Time.parse(end_time))
        sales_within_block << obj
      end
    end
    sales_within_block
  end





#  - returns a collection of Sale objects where the purchase time is between the two times given as arguments


#self.between(beginning_time, end_time) - returns a collection of Sale objects where the purchase time is between the two times given as arguments

end
