class FarMar::Sale < FarMar::Base

  attr_accessor :id,
                :amount,
                :purchase_time,
                :vendor_id,
                :product_id

  def initialize(attrs)
    @id             = attrs[:id]
    @amount         = attrs[:amount]
    @purchase_time  = Time.parse(attrs[:purchase_time])
    @vendor_id      = attrs[:vendor_id]
    @product_id     = attrs[:product_id]
  end

    def self.path
      "/Users/Chris/Code/class_projects/farmar/far_mar/support/sales.csv"
    end

    def self.all
      @all ||= all_calc
    end

    def self.all_calc
      CSV.read(path).map do |line|
        new(
          id:            line[0].to_i,
          amount:        line[1].to_i,
          purchase_time: line[2],
          vendor_id:     line[3].to_i,
          product_id:    line[4].to_i
        )
      end
    end

    def product
      @product ||= product_calc
    end

    def product_calc
      FarMar::Product.all.find do |prod|
        prod.id == @product_id
      end
    end

    def self.between(beginning_time, end_time)   
      bt = FarMar::Sale.find(beginning_time).purchase_time
      et = FarMar::Sale.find(end_time).purchase_time
      all.find_all do |sales|
        sales.purchase_time.between?(bt, et)
      end
    end

    def self.group_by_product
      all.group_by do |prod|
        prod.product_id
      end
    end

    def self.by_product(product_id)
      group_by_product[product_id]
    end

    def self.by_vendor(vendor_id)
      vendors = all.group_by do |v|
        v.vendor_id == vendor_id
      end
      vendors[vendor_id]
    end

end
