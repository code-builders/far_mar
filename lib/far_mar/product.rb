class FarMar::Product < FarMar::Base
  attr_accessor :id,
                :name,
                :vendor_id

  def initialize(attrs)
    @id        = attrs[0].to_i
    @name      = attrs[1]
    @vendor_id = attrs[2].to_i
  end

  def self.path
    "support/products.csv"
  end

  def self.by_vendor(vendor_id)
    all.find_all { |obj| obj.vendor_id == vendor_id }
  end

  def vendor
    FarMar::Vendor.find(vendor_id)
  end

  def sales
    FarMar::Sale.by_product(id)
  end

  def number_of_sales
    sales.count
  end

end
