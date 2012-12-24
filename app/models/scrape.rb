require "capybara"
require "capybara/dsl"
require "capybara-webkit"
Capybara.run_server = false
Capybara.current_driver = :webkit
Capybara.app_host = "http://www.google.com/"

module Scrape
  class Google
    include Capybara::DSL
    
    def save_keyword_results(keyword_id)
      keyword = Keyword.find(keyword_id)
      results = get_results(keyword.keyword_phrase)
      results.each_with_index do |result,i|
        if result[:url].include?(keyword.website.url)
          keyword.keyword_results.create(search_engine: "google", position: i+1, html: result[:html])          
          keyword.position = i+1
          keyword.save
          return
        end
      end
    end

    def get_results(keyword_phrase)
      wait = 8
      output = ""
      visit('/')
      fill_in "q", :with => keyword_phrase
      click_button "Google Search"  

      results = []

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|        
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        item[:page] = body
        results << item
      end

      sleep(wait)
      click_link "2"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        item[:page] = body
        results << item
      end

      sleep(wait)
      click_link "3"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        item[:page] = body
        results << item
      end

      sleep(wait)
      click_link "4"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        item[:page] = body
        results << item
      end

      sleep(wait)
      click_link "5"  

      all(:xpath, "//li[@class='g']/h3/a").each do |capy_element|
        item = {}
        item[:url] = capy_element[:href]
        item[:title] = capy_element.text
        item[:page] = body
        results << item
      end


      results
    end
  end
end