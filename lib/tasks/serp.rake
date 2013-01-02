namespace :serp do
  task :rank_keywords => :environment do    
    Keyword.all.each do |keyword|
      spider = Scrape::Google.new      
      spider.save_keyword_results(keyword.id)
    end
  end

  task :score_pages => :environment do

    while true
      #sleep(1)
      p = Page.where(:analyzed => false).first
      break if p.nil? 
      p.url = (p.url.index("http") == 0 ? "" : "http://") + p.url
  
      begin
        p.html = Curl.get(p.url).body_str
        
        if p.html == "Bad Request"
          p.destroy
        else
          puts p.url
          p.analyzed = true
          p.save

          p.internal_links.each do |link|      
            if Page.where(:source_report_id => p.source_report_id, :url => link).empty?
              Page.create(:source_report_id => p.source_report_id, :url => link) if link.length < 255
            end
          end
        end

      rescue
        puts "failed: #{p.url}"
        p.destroy

      end #rescue
    end #while
  end
end