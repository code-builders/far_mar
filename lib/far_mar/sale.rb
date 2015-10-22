class FarMar::Sale
  attr_accessor :id,
                :amount,
                :purchase_time,
                :vendor_id,
                :product_id

  def initialize(attrs)
    @id            = attrs[:id]
    @amount        = attrs[:amount]
    @purchase_time = attrs[:purchase_time]
    @vendor_id     = attrs[:vendor_id]
    @product_id    = attrs[:product_id]
  end

  def self.path
    "support/sales.csv"
  end

  def self.all
    CSV.read(path).map do |line|
      new(
        id:            line[0].to_i,
        amount:        line[1].to_f,
        purchase_time: line[2],
        vendor_id:     line[3].to_i,
        product_id:    line[4].to_i
      )
    end
  end

  def self.find(id)
    all.find do |obj|
      obj.id == id
    end
  end

  def vendor
    ven = FarMar::Vendor.all
    ven.find do |obj|
      obj.id == vendor_id
    end
  end

  def product
    pr = FarMar::Product.all
    pr.find do |obj|
      obj.id == product_id
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
