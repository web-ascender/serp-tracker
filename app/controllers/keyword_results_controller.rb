class KeywordResultsController < ApplicationController
  before_filter :set_client
  before_filter :set_website  
  before_filter :set_keyword

  def index
    @keyword_results = @keyword.keyword_results
  end
end
