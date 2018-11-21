class Store
  include Mongoid::Document

  field :name, type: String
  field :website, type: String
  field :logo, type: String
  field :email, type: String
  field :total_products
  
  #Relations
  has_many :products, dependent: :delete
 
  # Validations
  validates_presence_of :name, :website

  accepts_nested_attributes_for :products

  after_save :load_api_products, if: -> {website_changed? || total_products_changed?}

  rails_admin do
    create do
      field :name
      field :email
      field :logo
      field :website
      field :total_products
    end
  end

  private
  
  def load_products_api
    products.delete_all
    CacthProductsJob.perform_later(id.to_s)
  end
end
