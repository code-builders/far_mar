class FarMar::Market
  attr_accessor :id,
                :name,
                :address,
                :city,
                :county,
                :state,
                :zip

  def initialize(attrs)
    @id      = attrs[:id]
    @name    = attrs[:name]
    @address = attrs[:address]
    @city    = attrs[:city]
    @county  = attrs[:county]
    @state   = attrs[:state]
    @zip     = attrs[:zip]
  end

  def self.path
    "/Users/tamarapop/code_builders/projects/far_mar/support/markets.csv"
  end

  def self.all
    CSV.open(path).map do |line|
      new(
        id:        line[0],
        name:      line[1],
        address:   line[2],
        city:      line[3],
        county:    line[4],
        state:     line[5],
        zip:       line[6]
      )
    end
  end

  def self.find(id)

  end

end
