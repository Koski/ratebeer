class Place
  include ActiveModel::Model

  attr_accessor :id, :name, :status, :reviewlink, :proxylink, :blogmap, :street, :city, :state, :zip, :country, :phone, :overall, :imagecount
  
  def self.rendered_fields
    [:name, :street, :city, :zip, :country ]
  end

end
