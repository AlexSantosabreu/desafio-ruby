class Product
  include Mongoid::Document
  attr_accessor :reindex

  field :productName, type: String
  field :price, type: String
  field :quota, type: Integer
  field :product_image, type: String
  field :url_external, type: String
  field :reindex 
    
  #Relations
  belongs_to :store

  after_create :products_reindex, if: :reindex
  after_update :products_reindex, if: :name_changed?

  accepts_nested_attributes_for :store

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
      field :reindex, :hidden do
        default_value { true }
      end
     
    end  
  end
  
  private
  def products_reindex
    self.class.reindex
    
  end
  
end
