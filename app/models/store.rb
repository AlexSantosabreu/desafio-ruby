class Store
  include Mongoid::Document
  #include Mongoid::Slug

  field :name, type: String
  field :website, type: String
  field :logo, type: String
  field :email, type: String
  field :total_products
  field :slug, type: String
  field :on_home_page, type: Boolean, default: false

  index({slug: 1}, {unique: true})

  #slug
  #slug :name
  
  #Relations
  has_many :products, dependent: :delete
 
  # Validations
  validates_presence_of :name, :website
  validates_uniqueness_of :slug
  validates_uniqueness_of :on_home_page, if: :on_home_page?

  accepts_nested_attributes_for :products

  
  before_save :set_slug, if: -> { name_changed? || self.slug.blank? }
  after_save :load_products_api, if: -> {website_changed? || total_products_changed? }

  

  rails_admin do
    list do
      field :logo do
        pretty_value do
          bindings[:view].tag(:img, {:src => bindings[:object].logo, style: "width: 100px"})
        end
      end
      field :name
      field :email
      field :website
      field :total_products
      field :on_home_page
    end
    create do
      field :name
      field :email
      field :logo
      field :website
      field :total_products
      field :on_home_page
    end
  end

  private
  
  def load_products_api
    products.delete_all
    CacthProductsJob.perform_later(id.to_s)
  end

  def set_slug
    self.slug = I18n.transliterate(name).underscore.dasherize
  end
  

end
