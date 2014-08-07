ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

require 'support/capybara_helper'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :slow unless ENV["SLOW_SPECS"]
end
