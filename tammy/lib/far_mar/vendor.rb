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

  def self.by_market(market_id)
    all.find_all { |obj| obj.market_id == market_id }
  end

  def market
    FarMar::Market.find(market_id)
  end

  def products
    FarMar::Product.by_vendor(id)
  end

  def sales
    FarMar::Sale.by_vendor(id)
  end

  def revenue
    rev = sales.map { |obj| obj.amount }
    rev.inject(:+)/100
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
