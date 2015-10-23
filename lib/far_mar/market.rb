class FarMar::Market < FarMar::Base
  attr_accessor :id,
                :name,
                :address,
                :city,
                :county,
                :state,
                :zip

  def initialize(attrs)
    @id      = attrs[0].to_i
    @name    = attrs[1]
    @address = attrs[2]
    @city    = attrs[3]
    @county  = attrs[4]
    @state   = attrs[5]
    @zip     = attrs[6]
  end

  def self.path
    "support/markets.csv"
  end

  def self.find_by_state(state_name)
    row = CSV.read(path).find { |line| line[5] == state_name }
    FarMar::Market.new(row)
  end

  def self.find_all_by_state(state_name)
    all.find_all { |obj| obj.state == state_name }
  end

  def vendors
    FarMar::Vendor.by_market(id)
  end

end
