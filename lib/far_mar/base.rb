class FarMar::Base
  attr_accessor :attributes
  FILE = ("csv.csv")

  def initialize
    @attributes = :attributes
  end

  def self.all
    all_self = CSV.read(self::FILE)
    all_self.collect do |attrs|
    self.new(attrs)
    end
  end

  def self.find(id)
    all.find do |f|
      f.id == id
    end
  end

end
