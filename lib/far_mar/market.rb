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
    CSV.open(path).map do |line|
      new(
        id:      line[0].to_i,
        name:    line[1],
        address: line[2],
        city:    line[3],
        county:  line[4],
        state:   line[5],
        zip:     line[6]
        )
    end
  end

  def self.find(id)   # return the row where the ID field matches the arguement
      all.find do |obj|  # returns all markets as array
        obj.id == id                  # find the array with the "1"(argument) for :id
      end                 # return the whole array/line of that argument
  end

  def vendors
    vendor_list = FarMar::Vendors.all
    full_vendor_list = vendor_list.group_by do |obj|
      obj.market_id
    end
    full_vendor_list[@id]
    # find.group_by {|id| }

  end

  # def self.find(city)
  #     all.find do |obj|
  #       obj.city == city
  #     end
  # end

end
