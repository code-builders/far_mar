class FarMar::Vendors

  attr_accessor :id,
                :name,
                :no_of_employees,
                :market_id

  def initialize(attrs)
    @id               = attrs[:id]
    @name             = attrs[:name]
    @no_of_employees  = attrs[:no_of_employees]
    @market_id        = attrs[:market_id]
  end

    def self.path
      "/Users/Chris/Code/class_projects/farmar/far_mar/support/vendors.csv"
    end

    def self.all
      CSV.open(path).map do |line|
        new(
          id:              line[0].to_i,
          name:            line[1],
          no_of_employees: line[2].to_i,
          market_id:       line[3].to_i
          )
      end
    end

    def self.find(id)   # return the row where the ID field matches the argument
        all.find do |obj|  # returns all vendor objects as array
          obj.id == id                  # find the array with the (argument) for :id
        end                 # return the whole array/line of that argument
    end
end
