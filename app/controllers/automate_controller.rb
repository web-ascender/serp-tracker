class AutomateController < ApplicationController
  def index
    spider = Scrape::Google.new
    @results = spider.get_results
    @output = ""
  end
end
