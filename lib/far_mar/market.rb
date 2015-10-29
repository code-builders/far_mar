class FarMar::Market < FarMar::Base

attr_accessor :id,
              :name,
              :address,
              :city,
              :county,
              :state,
              :zip

def initialize(attrs)
  @id       = attrs[:id]
  @name     = attrs[:name]
  @address  = attrs[:address]
  @city     = attrs[:city]
  @county   = attrs[:county]
  @state    = attrs[:state]
  @zip      = attrs[:zip]
end

  def self.path
    "/Users/Chris/Code/class_projects/farmar/far_mar/support/markets.csv"
  end

  def self.all
    @all ||= all_calc
  end

  def self.all_calc
    CSV.read(path).map do |line|    # Read the markets.csv file
      new(                          # for each row
        id:      line[0].to_i,      # create a new instance of FarMar::Market
        name:    line[1],           # create an array of those instances
        address: line[2],           # return that new array
        city:    line[3],
        county:  line[4],
        state:   line[5],
        zip:     line[6].to_i
      )
    end
  end

  def vendors
    vendor_list = FarMar::Vendor.all.group_by do |obj|
      obj.market_id
    end
    vendor_list[@id]
  end

  def self.find_by_state(state_name)
    all.find do |obj|
      obj.state == state_name
    end
  end

  def self.find_all_state(state_name)
    all.find_all do |obj|
      obj.state == state_name
    end
  end

  def self.find_all_name(name)
    all_names = all.find_all do |n|
      n.name == name
    end
    if name.include?(name)
      all_names
    else
    end
  end

end
