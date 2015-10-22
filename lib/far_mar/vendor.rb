require 'csv'

class FarMar::Vendor
  attr_accessor :id, :name, :no_of_employees, :market_id

  def initialize(attrs)
   @id= attrs[:id].to_i
   @name = attrs[:name]
   @no_of_employees = attrs[:no_of_employees].to_i
   @market_id = attrs[:market_id].to_i
  end

  def self.all
    vendors = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/vendors.csv", "r")
    vendors.read.collect do |attrs|
      vend = {
        id: attrs[0].to_i,
        name: attrs[1],
        no_of_employees: attrs[2].to_i,
        market_id: attrs[3].to_i,
      }
      self.new(vend)
    end
  end

  def self.find(id)
    id = id.to_i
    vendors = self.all
    vendors.find do |f|
      f.id.to_i == id.to_i
    end
  end

  def market
    markets = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/markets.csv", "r")
    all_markets = markets.read.collect do |attrs|
      mkts = {
        id: attrs[0].to_i,
        name: attrs[1],
        address: attrs[2],
        city: attrs[3],
        county: attrs[4],
        state: attrs[5],
        zip: attrs[6].to_i
      }
      FarMar::Market.new(mkts)
    end
    all_markets.find_all do |f|
      f.id.to_i == self.market_id.to_i
    end
  end

  def products
    products = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/products.csv", "r")
    all_products = products.read.collect do |attrs|
      pdts = {
        id: attrs[0].to_i,
        name: attrs[1],
        vendor_id: attrs[2].to_i
      }
      FarMar::Product.new(pdts)
    end
    all_products.find_all do |f|
      f.vendor_id.to_i == self.id.to_i
    end
  end


#products - returns a collection of Product instances that are associated with the vendor by the Product vendor_id field.



  def sales
    sales = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/sales.csv", "r")
    all_sales = sales.read.collect do |attrs|
      sls = {
        id: attrs[0].to_i,
        amount: attrs[1].to_i,
        time_purchased: attrs[2],
        vendor_id: attrs[3].to_i,
        product_id: attrs[4].to_i,
      }
     FarMar::Sale.new(sls)
   end
    all_sales.find_all do |f|
      f.vendor_id.to_i == self.id.to_i
    end
  end

  def revenue #THIS IS A DISASTER
    all_sales = self.sales
    amounts = []
    all_sales.find_all do |s|
      amounts << s.amount.to_f/100
    end
    amounts.reduce(:+)
  end

  def self.by_market(market_id)
    all.find_all do |f|
      f.market_id.to_i == market_id.to_i
    end
  end

#expect(vendor.market.id).to eq vendor.market_id
#expect(FarMar::Vendor.by_market(100).first.name).to eq "Schiller-Ledner"

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
