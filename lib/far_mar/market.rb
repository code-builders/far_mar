class FarMar::Market

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
    CSV.open(path).map do |line|    # Read the markets.csv file
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

  def self.find(id)   # return the row where the ID field matches the arguement
      all.find do |obj|  # returns all markets as array
        obj.id == id                  # find the array with the "1"(argument) for :id
      end                 # return the whole array/line of that argument
  end

  def vendors
    vendor_list = FarMar::Vendor.all
    full_vendor_list = vendor_list.group_by do |obj|
      obj.market_id
    end
    full_vendor_list[@id]
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

end
