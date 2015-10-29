class FarMar::Base

  def self.find(id)
      all.find do |obj|
        obj.id == id
      end                
  end

  def vendor
    FarMar::Vendor.all.find do |v|
      v.id == @vendor_id
    end
  end

end
