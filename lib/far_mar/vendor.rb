class FarMar::Vendor < FarMar::Base

  attr_accessor :id, :name, :no_of_employees, :market_id

  def initialize (attrs)
    @id               = attrs[:id].to_i
    @name             = attrs[:name]
    @no_of_employees  = attrs[:no_of_employees].to_i
    @market_id        = attrs[:market_id].to_i
  end

  def self.read_file
    all_vendors = CSV.open("support/vendors.csv", "r")

    attributes = all_vendors.map do |v|
      { id:              v[0],
        name:            v[1],
        no_of_employees: v[2],
        market_id:       v[3]
      }
    end
  end

  # Note to self: here is where self.all and self.find(id) would go if we were to overwrite the
  # methods inherited from Base

  def market
    FarMar::Market.all.find {|m| m.id == self.market_id}
  end

  def products
    FarMar::Product.all.find_all {|p| p.vendor_id == self.id}
  end

  def sales
    FarMar::Sale.all.find_all {|s| s.vendor_id == self.id}
  end

  def revenue
    self.sales.map {|s| s.amount}.inject{|sum,x| sum + x }

    # still haven't gotten this to work:
    # self.sales.inject {|sum, sales| sum + sales.amount}
  end

  def self.by_market(market_id)
    self.all.find_all {|v| v.market_id.to_i == market_id}
  end

  def company_size
    if    no_of_employees <= 0
      puts "Check employee data in CSV"
    elsif no_of_employees <= 3
      puts "Family Business"
    elsif no_of_employees <= 15
      puts "Small Businesss"
    elsif no_of_employees <= 100
      puts "Medium Business"
    else
      puts "Big Business"
    end
  end

  # GOAL: vendor's sales grouped by hour and day. When do sales peak?
  def sales_by_hour
    self.sales.group_by {|s| s.purchase_time.hour}.map {|h| h[1].size}

    sales_grouped = self.sales.group_by {|s| s.purchase_time.hour} # => all times of sale, in hash form
    sales_grouped.map {|h| h[1].size}
  end

  def sales_by_day
    sales_grouped = self.sales.group_by {|s| s.purchase_time.day} # => all dates of sale, in hash form
    sales_grouped.map {|h| h[1].size}
  end

  def sale_amounts
    puts "TBD!" # self.sales.map
  end

end
