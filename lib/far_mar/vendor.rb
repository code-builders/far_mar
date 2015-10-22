class FarMar::Vendor < FarMar::Base
  attr_accessor :id,
                :name,
                :no_of_employees,
                :market_id

  def initialize(attrs)
    @id              = attrs[0].to_i
    @name            = attrs[1]
    @no_of_employees = attrs[2].to_i
    @market_id       = attrs[3].to_i
  end

  def self.path
    "support/vendors.csv"
  end

  def market
    list = FarMar::Market.all
    list.find do |obj|
      obj.id == @market_id
    end
  end

  def products
    products = FarMar::Product.all
    res = products.group_by do |obj|
      obj.vendor_id
    end
    res[id]
  end

  def sales
    sales = FarMar::Sale.all
    res = sales.group_by do |obj|
      obj.vendor_id
    end
    res[id]
  end

  def revenue
    all = sales.map do |obj|
      obj.amount
    end
    all.inject(:+)/100
  end

  def self.by_market(market_id)
    all.find_all do |obj|
      obj.market_id == market_id
    end
  end

  def company_size
    if no_of_employees <= 3
      "Family Business"
    elsif no_of_employees >= 4 && no_of_employees <= 15
      "Small Business"
    elsif no_of_employees >= 16 && no_of_employees <= 100
      "Medium Business"
    else
      "Big Business"
    end
  end

end
