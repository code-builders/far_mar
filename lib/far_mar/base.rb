class FarMar::Base

  attr_accessor :id

  def self.path
    ""
  end

  def self.all
    CSV.read(path).map do |line|
      new(line)
    end
  end

  def self.find(id)
    all.find do |obj|
      obj.id == id
    end
  end

end
