# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, options: {
      browser: :remote,
      url: 'http://chrome:4444/wd/hub'
    }
    Capybara.server_host = 'web'
  end
end
