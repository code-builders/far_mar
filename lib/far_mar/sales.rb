class FarMar::Sales

  attr_accessor :id,
                :amount,
                :purchase_time,
                :vendor_id,
                :product_id

  def initialize(attrs)
    @id             = attrs[:id]
    @amount         = attrs[:amount]
    @purchase_time  = attrs[:purchase_time]
    @vendor_id      = attrs[:vendor_id]
    @product_id     = attrs[:product_id]
  end

    def self.path
      "/Users/Chris/Code/class_projects/farmar/far_mar/support/sales.csv"
    end

    def self.all
      CSV.open(path).map do |line|
        new(
          id:            line[0].to_i,
          amount:        line[1].to_f / 100,
          purchase_time: line[2],
          vendor_id:     line[3],
          product_id:    line[4]
          )
      end
    end

    def self.find(id)   # return the row where the ID field matches the argument
        all.find do |obj|  # returns all sales objects as array
          obj.id == id                  # find the array with the (argument) for :id
        end                 # return the whole array/line of that argument
    end
end
