class FarMar::Market < FarMar::Base
  attr_accessor :id, :name, :address, :city, :county, :state, :zip

  def initialize (attrs)
    @id         = attrs[:id].to_i
    @name       = attrs[:name]
    @address    = attrs[:address]
    @city       = attrs[:city]
    @county     = attrs[:county]
    @state      = attrs[:state]
    @zip        = attrs[:zip]
  end

  def self.read_file
    CSV.read("support/markets.csv", "r").map do |m|
      { id:       m[0],
        name:     m[1],
        address:  m[2],
        city:     m[3],
        county:   m[4],
        state:    m[5],
        zip:      m[6]
      }
    end
  end

  # Note to self: this is where self.all and self.find(id) would go if we were
  # to overwrite the methods inherited from Base

  def vendors
    FarMar::Vendor.all.find_all {|v| v.market_id == self.id}
  end

  def vendors_by_revenue
    self.vendors.map {|v| "#{v.name}: $#{v.revenue/100}"}.sort_by {|v| v.revenue}
  end

  def self.find_by_state (state_name)
    self.all.find {|m| m.state == state_name}
  end

  def self.find_all_by_state (state_name)
    self.all.find_all {|m| m.state == state_name}
  end

  def self.markets_by_state
    self.all.group_by {|m| m.state}.sort.to_a.map do |a|
      puts "#{a[0]}: #{a[1].size} markets"
    end
  end
end
