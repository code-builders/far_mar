class FarMar::Sale < FarMar::Base
  attr_accessor :id,
                :amount,
                :purchase_time,
                :vendor_id,
                :product_id

  def initialize(attrs)
    @id            = attrs[0].to_i
    @amount        = attrs[1].to_f
    @purchase_time = Time.parse(attrs[2])
    @vendor_id     = attrs[3].to_i
    @product_id    = attrs[4].to_i
  end

  def self.path
    "support/sales.csv"
  end

  def vendor
    ven = FarMar::Vendor.all
    ven.find { |obj| obj.id == vendor_id }
  end

  def product
    pr = FarMar::Product.all
    pr.find { |obj| obj.id == product_id }
  end

  def self.between(beginning_time, end_time)
    all.find_all do |obj|
      beginning_time >= obj.purchase_time && end_time <= obj.purchase_time
    end
  end

  def self.by_product(product_id)
    all.find_all do |obj|
      obj.product_id == product_id
    end
  end

  def self.by_vendor(vendor_id)
    all.find_all do |obj|
      obj.vendor_id == vendor_id
    end
  end

end
