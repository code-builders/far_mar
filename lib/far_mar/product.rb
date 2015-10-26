class FarMar::Product < FarMar::Base

  attr_accessor :id,
                :name,
                :vendor_id

  def initialize(attrs)
    @id         = attrs[:id]
    @name       = attrs[:name]
    @vendor_id  = attrs[:vendor_id]
  end

    def self.path
      "/Users/Chris/Code/class_projects/farmar/far_mar/support/products.csv"
    end

    def self.all
      @all ||= all_calc
    end

    def self.all_calc
      CSV.read(path).map do |line|
        new(
          id:        line[0].to_i,
          name:      line[1],
          vendor_id: line[2].to_i
        )
      end
    end

    def sales                                     
      FarMar::Sale.group_by_product[@id]
    end

    def no_of_sales
      sales.count
    end

    def self.by_vendor(vendor_id)
      products = all.group_by do |prod|
        prod.vendor_id
      end
      products[vendor_id]
    end
end
