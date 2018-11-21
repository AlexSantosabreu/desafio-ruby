class Product
  include Mongoid::Document

  field :productName, type: String
  field :price, type: String
  field :quota, type: Integer
  field :product_image, type: String
  field :url_external, type: String

  #Relations
  belongs_to :store

  rails_admin do
    list do
      field :product_image do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].product_image, style: 'width:100px' })
        end
      end
      field :productName
      field :price
      field :quota
      field :store
    end
    create do
      field :product_image
      field :productName
      field :price
      field :quota
      field :store
     
    end  
  end

  
end
