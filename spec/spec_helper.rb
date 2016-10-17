# このrequire文は本に乗ってなかったけど...
# http://source.hatenadiary.jp/entry/2014/02/06/222318
require 'factory_girl_rails'
ENV["RAILS_ENV"] ||= 'test'
# 次のは263ページで
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
# 次のは259ページで
require 'capybara/rails'
require 'capybara/rspec'
# 次のは263ページで
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|

  config.fixture_path = "{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.before(:all, type: :feature) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: '12345',
      info: {
        nickname: 'netwillnet',
        image: 'http://example.com/netwillnet.jpg'
      }
    })
  end

  # 252ページで追加されました
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # 次のは263ページで
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end
