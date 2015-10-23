class FarMar::Product < FarMar::Base

  attr_accessor :id, :name, :vendor_id

  def initialize (attrs)
    @id        = attrs[:id].to_i
    @name      = attrs[:name]
    @vendor_id = attrs[:vendor_id].to_i
  end

  def self.read_file
    all_products = CSV.read("support/products.csv", "r")

    all_products.map do |pr|
      { id:       pr[0],
        name:     pr[1],
        vendor_id:pr[2]
      }
    end
  end

  # Note to self: here is where self.all and self.find(id) would go if we were to overwrite the
  # methods inherited from Base

  def self.by_vendor(vendor_id)
    self.all.find_all {|p| p.vendor_id == vendor_id}
  end

  def vendor
    FarMar::Vendor.all.find {|v| v.id == self.vendor_id}
  end

  def sales
    FarMar::Sale.all.find_all {|s| s.product_id == self.id}
  end

  def number_of_sales
    sales.count
  end
end
