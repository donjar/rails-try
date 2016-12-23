ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module ActionDispatch
  class IntegrationTest
    # Make the Capybara DSL available in all integration tests
    include Capybara::DSL

    Capybara.register_driver :long_selenium do |app|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 180 # instead of the default 60
      Capybara::Selenium::Driver.new(app, browser: :firefox,
                                     http_client: client)
    end

    Capybara.default_driver = :long_selenium

    # Reset sessions and driver between tests
    # Use super wherever this method is redefined in your
    # individual test classes
    def teardown
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end
