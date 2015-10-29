class FarMar::Vendor < FarMar::Base

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
      @all ||= all_calc
    end

    def self.all_calc
      CSV.read(path).map do |line|
        new(
          id:              line[0].to_i,
          name:            line[1],
          no_of_employees: line[2].to_i,
          market_id:       line[3].to_i
        )
      end
    end

    def market
      FarMar::Market.all.find do |obj|
        obj.id == @market_id
      end
    end

    def products
      product = FarMar::Product.all.group_by do |prod|
        prod.vendor_id
      end
      product[@id]
    end

    def sales
      @sales ||= sales_calc
    end

    def sales_calc
      sale = FarMar::Sale.all.group_by do |sales|
        sales.vendor_id
      end
      sale[@id]
    end

    def revenue
      @revenue ||= revenue_calc
    end

    def revenue_calc
      sum = sales.map do |amnt|
      amnt.amount.to_f / 100
      end
      sum.reduce(:+).to_s
    end

    def rev_by_employee               # Added method
      revenue.to_f / no_of_employees
    end

    def self.by_market(market_id)
      all.find_all do |obj|
        obj.market_id == market_id
      end
    end

    def company_size
      @company_size ||= company_size_calc
    end

    def company_size_calc
      if
        no_of_employees <= 3
        "Family Business"
      elsif
        no_of_employees > 3 && no_of_employees < 16
        "Small Business"
      elsif
        no_of_employees > 15 && no_of_employees < 101
        "Medium Business"
      else
        "Big Business"
      end
    end
end
