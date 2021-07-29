# Capybara.register_driver :chrome_headless do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     'goog:chromeOptions': {
#       args: %w[ no-sandbox headless disable-gpu --window-size=1920,1080]
#     }
#   )
#   Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
# end

#Ensure Log directory exists
%x(mkdir -p tmp/selenium_logs)

Capybara.register_driver :chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions': { args: %w[ start-maximized ] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    driver_opts: {
      log_path: "./tmp/selenium_logs/selenium-#{Time.now.to_i}.log",
      verbose: true
    }
  )
end

Capybara.register_driver :headless_firefox do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Firefox::Options.new
  browser_options.args << '-headless'
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: browser_options)
end

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--headless'
    opts.args << '--disable-gpu' if Gem.win_platform?
    # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
    opts.args << '--disable-site-isolation-trials'
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.javascript_driver = :headless_chrome

# Capybara.javascript_driver = ENV.fetch('CAPYBARA_JAVASCRIPT_DRIVER', :chrome_headless).to_sym

#must allow this URL if Webdrivers needs to download a binary
#WebMock.disable_net_connect!(allow: 'chromedriver.storage.googleapis.com', allow_localhost: true)
