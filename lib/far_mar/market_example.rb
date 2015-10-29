class FarMar::Markets

  attr_accessor :name, :id, :address, :county, :city, :state, :zip

  def initialize(attrs)
    @id       = attrs[0]
    @name     = attrs[1]
    @address  = attrs[2]
    @city     = attrs[3]
    @county   = attrs[4]
    @state    = attrs[5]
    @zip      = attrs[6]
  end

  def self.all
    read_file.collect do |row|
      FarMar::Market.new(row)
    end
  end

  def self.find(i)
    all.find do |m|
      m.id.to_i == i
    end
  end
end

def self.read_file
  CSV.read("support/markets.csv")
end
