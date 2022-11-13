# frozen_string_literal: true

class ProductsController < AuthenticatedController
  def index
    @products = ShopifyAPI::Product.all(limit: 10)
    puts @products.as_json
    render(json: { products: @products })
  end
end
