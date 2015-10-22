require 'csv'

class FarMar::Product
  attr_accessor :id, :name, :vendor_id

  def initialize(attrs)
   @id= attrs[0].to_i
   @name = attrs[1]
   @vendor_id = attrs[2].to_i
  end

  def self.all
    products = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/products.csv", "r")
    products.read.collect do |attrs|
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
    all_vendors[@vendor_id]
  end

  def sales
    sales = FarMar::Sale.all
    all_sales = sales.group_by do |obj|
      obj.product_id
    end
    all_sales[@id]
  end

  def number_of_sales
    all_sales = self.sales
    times = []
    all_sales.find_all do |s|
      times << s.product_id
    end
    times.count
  end

  def self.by_vendor(vendor_id)
    all_products = self.all.group_by do |obj|
      obj.vendor_id
    end
    all_products[vendor_id]
  end

end
