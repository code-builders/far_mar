class FarMar::Vendor
  attr_accessor :id,
                :name,
                :no_of_employees,
                :market_id

  def initialize(attrs)
    @id              = attrs[:id]
    @name            = attrs[:name]
    @no_of_employees = attrs[:no_of_employees]
    @market_id       = attrs[:market_id]
  end

  def self.path
    "support/vendors.csv"
  end

  def self.all
    CSV.read(path).map do |line|
      new(
        id:              line[0].to_i,
        name:            line[1],
        no_of_employees: line[2].to_i,
        market_id:       line[3].to_i
      )
    end
  end

  def self.find(id)
    all.find do |obj|
      obj.id == id
    end
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
    res[@id]
  end

end
