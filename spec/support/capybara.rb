# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    if ENV['HEADED'].present?
      driven_by :selenium, using: :chrome
    else
      driven_by(:selenium, using: :headless_chrome) do |driver_option|
        driver_option.add_argument('--no-sandbox')
        driver_option.add_argument('--disable-dev-shm-usage')
      end
    end
  end
end
