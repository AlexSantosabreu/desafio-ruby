class Store
  include Mongoid::Document

  field :name, type: String
  field :website, type: String
  field :logo, type: String
  field :email, type: String
  embedded_in :user
  
  #Relations
  has_many :products, dependent: :delete
 
  # Validations

end
