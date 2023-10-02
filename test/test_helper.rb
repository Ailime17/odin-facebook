ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  def log_in(user)
    get '/users/sign_in'
    if integration_session
      login_as(user, scope: :user)
    else
      sign_in(user)
    end
    post user_session_url
  end

  # Add more helper methods to be used by all tests here...
end
