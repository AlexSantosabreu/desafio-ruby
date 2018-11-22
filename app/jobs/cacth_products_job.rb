class CacthProductsJob < ApplicationJob
  require 'httparty'

  queue_as :default
  
  ROWS = 49
  
  def perform(store_id)

    store = Store.find(store_id)

    product_list = []

    (store.total_products/ROWS).ceil.times do |page|
      response = HTTParty.get("#{website(store)}/api/catalog_system/pub/products/search",
                 :query => "_from=#{page*ROWS}&_to=#{(page+1)*ROWS}").parsed_response
      response.each do |resp|
        product_list << {
          store_id: store.id,
          productName: resp["productName"],
          url_external: resp["link"],
          product_image: resp["items"][0]["images"][0]["imageUrl"],
          price: resp["items"][0]["sellers"][0]["commertialOffer"]["Price"],
          quota: resp["items"][0]["sellers"][0]["commertialOffer"]["Installments"].map { |c| c["NumberOfInstallments"] }.max
          
        }
      end
    end
    Product.collection.insert_many(product_list)
    Product.reindex
  end

  private

  def website(store)
    _website = store.website 
    _website.last == '/' ? _website[0..-2] : _website
  end
end
