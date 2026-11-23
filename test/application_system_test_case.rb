require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1280, 900] do |options|
    options.binary = ENV.fetch("CHROME_BIN") if ENV["CHROME_BIN"].present?
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--no-sandbox") if ENV["CHROME_NO_SANDBOX"] == "1"
  end
end
