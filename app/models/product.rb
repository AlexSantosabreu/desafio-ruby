class Product
  include Mongoid::Document

  field :name, type: String
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
      field :name
      field :price
      field :quota
      field :store
    end
    create do
      field :name
      field :avatar
      field :price
      field :installments
      field :store
     
    end  
  end

  
end
