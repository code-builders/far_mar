class FarMar::Product
  attr_accessor :id,
                :name,
                :vendor_id

  def initialize(attrs)
    @id        = attrs[:id]
    @name      = attrs[:name]
    @vendor_id = attrs[:vendor_id]
  end

  def self.path
    "support/products.csv"
  end

  def self.all
    CSV.read(path).map do |line|
      new(
        id:        line[0].to_i,
        name:      line[1],
        vendor_id: line[2].to_i
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
