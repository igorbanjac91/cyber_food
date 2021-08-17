
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

Capybara.register_driver :chrome_headless do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions': {
      args: %w[ no-sandbox headless disable-gpu --window-size=1920,1080]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end


Capybara.register_driver :firefox_headless do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Firefox::Options.new
  browser_options.args << '-headless'
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: browser_options)
end

Capybara.default_max_wait_time = 4

Capybara.javascript_driver = :chrome_headless

