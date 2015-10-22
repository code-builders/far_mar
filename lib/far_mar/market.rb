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

  def vendors
    list = FarMar::Vendor.all
    ans = list.group_by do |obj|
      obj.market_id
    end
    ans[id]
  end

  def self.find_by_state(state_name)
    all.find do |obj|
      obj.state == state_name
    end
  end

  def self.find_all_by_state(state_name)
    all.find_all do |obj|
      obj.state == state_name
    end
  end

end
