class FarMar::Product
  attr_accessor :id,
                :name,
                :vendor_id

  def initialize(attrs)
    @id        = attrs[:id]
    @name      = attrs[:name]
    @vendor_id = attrs[:vendor_id]
  end

  def self.path
    "support/products.csv"
  end

  def self.all
    CSV.read(path).map do |line|
      new(
        id:        line[0].to_i,
        name:      line[1],
        vendor_id: line[2].to_i
      )
    end
  end

  def self.find(id)
    all.find do |obj|
      obj.id == id
    end
  end

end
