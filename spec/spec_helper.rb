# このrequire文は本に乗ってなかったけど...
# http://source.hatenadiary.jp/entry/2014/02/06/222318
require 'factory_girl_rails'
# 次のは259ページで
require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|

  config.before(:all, type: :feature) do
    OmniAuth.config.(test_mode) = true
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

end
