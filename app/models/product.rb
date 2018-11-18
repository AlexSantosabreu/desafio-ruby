class Product
  include Mongoid::Document

  field :name, type: String
  field :price, type: Decimal
  field :quota, type: Integer
  field :product_image, type: String
  field :url_external, type: String
  
end
