$PROJECT_HOME = File.join(File.dirname(__FILE__), '..', '..')
$LOAD_PATH.unshift(File.join($PROJECT_HOME, 'lib'))
require 'rspec'
require 'fileutils'
require 'rubygems'
require 'selenium-webdriver'
require 'logger'
require 'bundler/setup'
require 'page-object'
require 'rspec/expectations'
require 'page-object/page_factory'
require 'require_all'
require 'active_record'
require 'factory_girl'
require 'yaml'

require_all('lib')
World(PageObject::PageFactory)

$LOG = Logger.new(STDOUT)
$START_TIME ||= Time.now

def browser_name
	(ENV['BROWSER'] ||= 'firefox').downcase.to_sym
end

Before do |scenario|
  FactoryGirl.find_definitions

  if ENV['SITE']
    @driver = Selenium::WebDriver.for(:chrome)
    @base_addr = ENV['SITE']
	  @driver.navigate.to(@base_addr)

    # Test instance constants. In a real project, should find a different place for these,
    # or attach them to a meta tag
    @pay_periods_per_year = 26
  else
    raise 'Please pass argument "SITE" as command line argument.'
  end
end

After do |scenario|
  if @driver
    if scenario.failed?
      failed_feature = scenario.feature.name.downcase.gsub(' ', '_')
      failed_scenario = scenario.name.downcase.gsub(' ', '_')
      run_folder = $START_TIME.strftime('%Y-%b-%d_%H %M %S')

      screenshot_name = "#{failed_scenario}.png"

      folder = File.join($PROJECT_HOME, 'screenshots', run_folder, failed_feature)
      FileUtils::mkdir_p(folder)


      filename = File.join(folder, screenshot_name)
      @driver.save_screenshot(filename)
    end
    @driver.quit
  end
end