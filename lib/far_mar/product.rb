class FarMar::Product

  attr_accessor :id,
                :name,
                :vendor_id

  def initialize(attrs)
    @id         = attrs[:id]
    @name       = attrs[:name]
    @vendor_id  = attrs[:vendor_id]
  end

    def self.path
      "/Users/Chris/Code/class_projects/farmar/far_mar/support/products.csv"
    end

    def self.all
      CSV.open(path).map do |line|
        new(
          id:        line[0].to_i,
          name:      line[1],
          vendor_id: line[2].to_i
          )
      end
    end

    def self.find(id)   # return the row where the ID field matches the argument
        all.find do |obj|  # returns all product objects as array
          obj.id == id                  # find the array with the (argument) for :id
        end                 # return the whole array/line of that argument
    end
end
