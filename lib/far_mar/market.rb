class FarMar::Market < FarMar::Base
  attr_accessor :id, :name, :address, :city, :county, :state, :zip
  FILE = ("/Users/khambro/CodeBuilders/far_mar/support/markets.csv")

  def initialize(attrs)
   @id= attrs[0].to_i
   @name = attrs[1]
   @address = attrs[2]
   @city = attrs[3]
   @county = attrs[4]
   @state = attrs[5]
   @zip = attrs[6].to_i
  end

  def vendors
    vendors = FarMar::Vendor.all
    all_vendors = vendors.group_by do |obj|
      obj.market_id
    end
    all_vendors[@id]
  end

  def self.find_by_state_name(state_name)
    state_name = state_name.to_s
    self.all.find do |f|
      f.state == state_name
    end
  end

  def self.find_all_by_state_name(state_name)
    state_name = state_name.to_s
    self.all.find_all do |f|
      f.state == state_name
    end
  end

end
