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
    "/Users/tamarapop/code_builders/projects/far_mar/support/products.csv"
  end

  def self.all
    CSV.open(path).map do |line|
      new(
        id:        line[0].to_i,
        name:      line[1],
        vendor_id: line[3].to_i
      )
    end
  end

  def self.find(id)
    all.find do |obj|
      obj.id == id
    end
  end

end
