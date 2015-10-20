class FarMar::Sale
  attr_accessor :id,
                :amount,
                :purchase_time,
                :vendor_id,
                :product_id

  def initialize(attrs)
    @id            = attrs[:id]
    @amount        = attrs[:amount]
    @purchase_time = attrs[:purchase_time]
    @vendor_id     = attrs[:vendor_id]
    @product_id    = attrs[:product_id]
  end

  def self.path
    "/Users/tamarapop/code_builders/projects/far_mar/support/sales.csv"
  end

  def self.all
    CSV.open(path).map do |line|
      new(
        id:            line[0].to_i,
        amount:        line[1].to_f/100,
        purchase_time: line[2],
        vendor_id:     line[3].to_i,
        product_id:    line[4].to_i
      )
    end
  end

  def self.find(id)
    all.find do |obj|
      obj.id == id
    end
  end

end
