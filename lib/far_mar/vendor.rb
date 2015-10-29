class FarMar::Vendor < FarMar::Base
  attr_accessor :id, :name, :no_of_employees, :market_id
  FILE = ("support/vendors.csv")

  def initialize(attrs)
   @id= attrs[0].to_i
   @name = attrs[1]
   @no_of_employees = attrs[2].to_i
   @market_id = attrs[3].to_i
  end


  def market
    markets = FarMar::Market.all
    all_markets = markets.group_by do |obj|
      obj.id
    end
    all_markets[@id].first
  end


  def products
    products = FarMar::Product.all
    all_products = products.group_by do |obj|
      obj.vendor_id
    end
    all_products[@id]
  end


  def sales
    sales = FarMar::Sale.all
    all_sales = sales.group_by do |obj|
      obj.vendor_id
    end
    all_sales[@id]
  end


  def revenue
    amounts = []
    self.sales.find_all do |s|
      amounts << s.amount.to_f/100
    end
    amounts.reduce(:+)
  end

  def self.by_market(market_id)
    all_vends= self.all.group_by do |obj|
      obj.market_id
    end
    all_vends[market_id]
  end


  def company_size
    if @no_of_employees <= 3
      puts "Family Business"
    end
    if @no_of_employees >= 4 && @no_of_employees <=15
      puts "Small Business"
    end
    if @no_of_employees >= 16 &&  @no_of_employees <=100
      puts "Medium Business"
    end
    if @no_of_employees > 100
      puts "Big Business"
    end
  end

end
