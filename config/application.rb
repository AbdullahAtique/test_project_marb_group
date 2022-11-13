require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
if ['development', 'test'].include? ENV['RAILS_ENV']
  Dotenv::Railtie.load
end
ShopifyAPI::Context.setup(
  api_key: ENV.fetch('SHOPIFY_API_KEY', '').presence,
  api_secret_key: ENV.fetch('SHOPIFY_API_SECRET', '').presence,
  host: ENV.fetch('HOST', '').presence,
  scope: "read_orders,read_products,etc",
  session_storage: ShopifyAPI::Auth::FileSessionStorage.new, # See more details below
  is_embedded: true, # Set to true if you are building an embedded app
  is_private: false, # Set to true if you are building a private app
  api_version: "2022-01" # The version of the API you would like to use
)

module TestProjectMarbGroup
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
