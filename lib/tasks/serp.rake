namespace :serp do
  task :rank_keywords => :environment do    
    Keyword.all.each do |keyword|
      spider = Scrape::Google.new      
      spider.save_keyword_results(keyword.id)
    end
  end
end