# frozen_string_literal: true

class ProductsController < AuthenticatedController
  # include ShopifyApp::ShopAccessScopesVerification

  def index
    @products = ShopifyAPI::Product.all(limit: 10)
    render(json: { products: @products })
  end

  def clone_product
    product_to_be_cloned = ShopifyAPI::Product.find(id: params[:product_id])

    product = ShopifyAPI::Product.new
    product.title = "Copy of #{product_to_be_cloned.title}"
    product.vendor = "MG Test Store 2" if current_shopify_session.shop =='mg-test-store-1.myshopify.com'
    product.vendor = "MG Test Store 1" if current_shopify_session.shop =='mg-test-store-2.myshopify.com'
    product.product_type = product_to_be_cloned.product_type
    product.status = product_to_be_cloned.status
    product.save!
    head :ok
  end

  private

  def find_product
    @product = Product.find
    product_id = params[:id]
    # `session` is built as part of the OAuth process
    client = ShopifyAPI::Clients::Rest::Admin.new(
      session: session
    )
    response = client.get(
      path: "products/#{product_id}",
      query: ["id" => 1, "title" => "title"]
    )
  end
end
