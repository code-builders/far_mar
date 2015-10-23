class FarMar::Base

  def self.all
    CSV.read(path).map { |line| new(line) }
  end

  def self.find(id)
    all.find { |obj| obj.id == id }
  end

end
