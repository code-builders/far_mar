class FarMar::Product < FarMar::Base
  attr_accessor :id, :name, :vendor_id
  FILE = ("/Users/khambro/CodeBuilders/far_mar/support/products.csv")

  def initialize(attrs)
   @id= attrs[0].to_i
   @name = attrs[1]
   @vendor_id = attrs[2].to_i
  end


  def vendor
    vendors = FarMar::Vendor.all
    all_vendors = vendors.group_by do |obj|
      obj.id
    end
    all_vendors[@vendor_id].first
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
