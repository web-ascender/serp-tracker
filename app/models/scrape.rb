require "capybara"
require "capybara/dsl"
require "capybara-webkit"
Capybara.run_server = false
Capybara.current_driver = :webkit
Capybara.app_host = "http://www.google.com/"

module Scrape
  class Google
    include Capybara::DSL
    
    def get_results
      wait = 3
      output = ""
      visit('/')
      fill_in "q", :with => "Capybara Rails"
      click_button "Google Search"  

      results = []

      p = all(:xpath,"//html")
      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|        
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        item[:page] = p
        results << item
      end

      sleep(wait)
      click_link "2"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        results << item
      end

      sleep(wait)
      click_link "3"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        results << item
      end

      sleep(wait)
      click_link "4"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        results << item
      end

      sleep(wait)
      click_link "5"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        results << item
      end


      results
    end
  end
end