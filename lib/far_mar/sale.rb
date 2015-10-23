## TO DO
# -refactor time formatting w/ .strftime for better readability
# -refactor self.between method for more user_friendly input (not assign variables, use Time.parse)

class FarMar::Sale < FarMar::Base

  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize (attrs)
    @id             = attrs[:id].to_i
    @amount         = attrs[:amount].to_i
    @purchase_time  = Time.parse(attrs[:purchase_time]) # => format w/ .strftime ?
    @vendor_id      = attrs[:vendor_id].to_i
    @product_id     = attrs[:product_id].to_i
  end

  def self.read_file
    all_sales = CSV.read("support/sales.csv", "r")

    attributes = all_sales.map do |s|
      { id:             s[0],
        amount:         s[1],
        purchase_time:  s[2],
        vendor_id:      s[3],
        product_id:     s[4]
      }
    end
  end

  # Note to self: here is where self.all and self.find(id) would go if we were to overwrite the
  # methods inherited from Base

  def vendor
    FarMar::Vendor.all.find {|v| v.id == self.vendor_id}
  end

  def product
    FarMar::Product.all.find {|pr| pr.id == self.product_id}
  end

  def self.between(beginning_time, end_time)
    self.all.find_all {|s| s.purchase_time >= beginning_time && s.purchase_time <= end_time}
  end

  def self.by_product(product_id)
    self.all.find_all {|s| s.product_id == product_id}
  end

  def self.by_vendor(vendor_id)
    self.all.find_all {|s| s.vendor_id == vendor_id}
  end
end
