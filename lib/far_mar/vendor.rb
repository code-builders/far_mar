class FarMar::Vendor

  attr_accessor :id,
                :name,
                :no_of_employees,
                :market_id

  def initialize(attrs)
    @id               = attrs[:id]
    @name             = attrs[:name]
    @no_of_employees  = attrs[:no_of_employees]
    @market_id        = attrs[:market_id]
  end

    def self.path
      "/Users/Chris/Code/class_projects/farmar/far_mar/support/vendors.csv"
    end

    def self.all
      CSV.open(path).map do |line|
        new(
          id:              line[0].to_i,
          name:            line[1],
          no_of_employees: line[2].to_i,
          market_id:       line[3].to_i
          )
      end
    end

    def self.find(id)   # return the row where the ID field matches the argument
        all.find do |obj|  # returns all vendor objects as array
          obj.id == id                  # find the array with the (argument) for :id
        end                 # return the whole array/line of that argument
    end

    def market
      market = FarMar::Market.all
      market.find do |obj|
        obj.id == @market_id
      end
    end

    def products
      product = FarMar::Product.all
      products_by_vendor = product.group_by do |prod|
        prod.vendor_id
      end
      products_by_vendor[@id]
    end

    def sales
      sale = FarMar::Sale.all
      sales_by_vendor = sale.group_by do |sales|
        sales.vendor_id
      end
      sales_by_vendor[@id]
    end

    def revenue
      sum = sales.map do |amnt|
      amnt.amount
      end
      "$" + sum.reduce(:+).to_s
    end

    def self.by_market(market_id)
      all.find_all do |obj|
        obj.market_id == market_id
      end
    end

    def company_size
      if
        no_of_employees <= 3
        puts "Family Business"
      elsif
        no_of_employees > 3 && no_of_employees < 16
        puts "Small Business"
      elsif
        no_of_employees > 15 && no_of_employees < 101
        puts "Medium Business"
      else
        puts "Big Business"
      end
    end
end
