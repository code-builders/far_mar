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

  def vendor
    ven = FarMar::Vendor.all
    ven.find do |obj|
      obj.id == vendor_id
    end
  end

  def sales
    sale = FarMar::Sale.all
    sale.find_all do |obj|
      obj.product_id == id
    end
  end

  def number_of_sales
    sales.count
  end

  def self.by_vendor(vendor_id)
    all.find_all do |obj|
      obj.vendor_id == vendor_id
    end
  end

end
