class FarMar::Sale

  attr_accessor :id,
                :amount,
                :purchase_time,
                :vendor_id,
                :product_id

  def initialize(attrs)
    @id             = attrs[:id]
    @amount         = attrs[:amount]
    @purchase_time  = attrs[:purchase_time]
    @vendor_id      = attrs[:vendor_id]
    @product_id     = attrs[:product_id]
  end

    def self.path
      "/Users/Chris/Code/class_projects/farmar/far_mar/support/sales.csv"
    end

    def self.all
      CSV.open(path).map do |line|
        new(
          id:            line[0].to_i,
          amount:        line[1].to_i,
          purchase_time: line[2],
          vendor_id:     line[3].to_i,
          product_id:    line[4].to_i
          )
      end
    end

    def self.find(id)   # return the row where the ID field matches the argument
        all.find do |obj|  # returns all sales objects as array
          obj.id == id                  # find the array with the (argument) for :id
        end                 # return the whole array/line of that argument
    end

    def vendor                          # Have the opportunity to create one method between this and product class # refactor
      FarMar::Vendor.all.find do |v|
        v.id == @vendor_id
      end
    end

    def product                             # look to create a method between this and product glass, etc. DRY
      FarMar::Product.all.find do |prod|
        prod.id == @product_id
      end
    end

    def self.between(beginning_time, end_time)              # This makes a collection of items sold between 1 sale id and another... Refactor to make a time entered relevant.
      bt = FarMar::Sale.find(beginning_time).purchase_time
      et = FarMar::Sale.find(end_time).purchase_time
      all.find_all do |sales|
      sales.purchase_time.between?(bt, et)
      end
    end

    def self.by_product(product_id)
      products = all.group_by do |prod|
        prod.product_id
      end
      products[product_id]
    end

    def self.by_vendor(vendor_id)
      vendors = all.group_by do |v|
        v.vendor_id
      end
      vendors[vendor_id]
    end

end
