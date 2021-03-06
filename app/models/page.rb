class Page < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id
  belongs_to :source_report
  before_save :calculate_depth

  EXCLUDED_WORDS = "the be to of and a in that have I it for not on with he as you do at  this but his by from they we say her she or an will my one all would there their what  so up out if about who get which go me when make can like time no just him know take  people into year your good some could them see other than then now look only come its over think also  back after use two how our work first well way even new want because any these give day most us " 
  CAUTION_WORDS = ["Link Exchange","link trade","link swap","trade links"]

  def title
    doc = Nokogiri::HTML(self.html)
    doc.xpath('//title').text
  end

  def title_complexity_score
    self.title_array.count
  end

  def title_focus
    title_array
  end

  def title_array
    page_title = self.title
    page_title = page_title.gsub("<","|")
    page_title = page_title.gsub("&gt;","|")
    page_title = page_title.gsub("&lt;","|")
    page_title = page_title.gsub(">","|")
    page_title = page_title.gsub("-","|")
    page_title.split("|").collect(&:strip)
  end

  def path
    p = self.url.gsub("http://","")
    p = p.gsub("https://","")
    p.index("/").nil? ? "" : p[p.index("/"),2000]
  end

  def domain
    p = self.url.gsub("http://","")
    p = p.gsub("https://","")
    if p.index("/").nil?    
      p
    else
      p[0,p.index("/")] 
    end
  end

  def text
    doc = Nokogiri::HTML(self.html)
    doc.xpath('//text()').map{|e| e.to_s}.join(" ")
  end

  def find_phrase(phrase)
    text.downcase.scan(phrase.downcase).count
  end

  def title_density
    term_count = 0
    title_array.each do |t|
      term_count += find_phrase(t)
    end
    term_count - title_array.count #it counts itself in the title
  end

  def tables
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//table").map{|e| e.text}
  end

  def h1s
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//h1").map{|e| e.text}
  end
  def h2s
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//h2").map{|e| e.text}
  end
  def h3s
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//h3").map{|e| e.text}
  end

  def paragraphs
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//p").map{|e| e.text}
  end

  def divs
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//div").map{|e| e.text}
  end

  def tables
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//table").map{|e| e.text}
  end

  def image_count
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//img").count
  end
  
  def alt_image_text
    doc = Nokogiri::HTML(self.html)    
    doc.xpath('//img[@alt!=""]').collect{|e|e.attr("alt")} || []
  end

  def image_names
    doc = Nokogiri::HTML(self.html)    
    doc.xpath('//img[@src!=""]').collect{|e| e.attr("src").split("/").last } || []    
  end

  def image_name_density
    score = 0
    assume_keywords_single_words.each do |t|
      score += image_names.join(" ").scan(t).count unless EXCLUDED_WORDS.include?(t)
    end
    score
  end

  def strong
    doc = Nokogiri::HTML(self.html)    
    doc.xpath("//b").map{|e| e.text} | doc.xpath("//strong").map{|e| e.text}
  end


  def path_too_complex?    
    return true if path.scan("/").count > 4
    return true if path.length > 60    
    return true if path.scan("&").count > 1
    return false
  end

  def javascript_too_complex?(threshold)
    javascript.gsub(' ','').length > threshold
  end

  def javascript
    doc = Nokogiri::HTML(self.html)   
    doc.xpath("//script").text
  end

  def css_too_complex?(threshold)
    css.gsub(' ','').length > threshold    
  end

  def css
    doc = Nokogiri::HTML(self.html)   
    doc.xpath("//style").text
  end

  def too_few_words?(threshold)
    self.words < threshold
  end

  def too_many_words?(threshold)
    self.words  > threshold
  end

  def too_many_inline_styles?(threshold)
    inline_style_count > threshold
  end

  def inline_style_count
    self.html.scan('style="').count + self.html.scan("style='").count
  end

  def words
    text.split(" ").count
  end

  def internal_links
    i_links = []
    links.each do |l|
      root_addr = self.url.index("https") == 0 ? "https://" : "http://" +  self.domain      

      unless l.index("http") == 0      
        l =  root_addr + (l.index("/") == 0 ? "" : "/") + l   
      end

      if !l.index(self.domain).nil? && l.index(self.domain) < 8
        i_links << l
      end
    end
    i_links 


  end

  def external_links
    e_links = []
    links.each do |l|
      root_addr = self.url.index("https") == 0 ? "https://" : "http://" +  self.domain      
      unless l.index("http") == 0      
        l =  root_addr + (l.index("/") == 0 ? "" : "/") + l   
      end
      unless l.include?(self.domain)
        e_links << l
      end
    end
    e_links
  end


  def links
    doc = Nokogiri::HTML(self.html)  
    anchors = []
    doc.xpath('//a[@href!=""]').each do |e|
      anchors << e.attr("href") if valid_page(e.attr("href"))
    end
    anchors
  end

  def li_link_count
    doc = Nokogiri::HTML(self.html)   
    doc.xpath("//li/a").count
  end

  def assume_keywords
    doc = Nokogiri::HTML(self.html)        
    keywords = []
    keywords = keywords | title_array

    #META KEYWORDS
    begin
      keywords = keywords | doc.xpath('//meta[@name="keywords"]').attr("content").value.split(",")
    rescue

    end

    keywords = keywords | self.h1s
    keywords = keywords | self.h2s
    #keywords = keywords | self.strong

    keywords.each_with_index do |k,i|
      keywords[i] = k.gsub("\n","")
      keywords[i] = k.strip      
    end
    keywords.uniq
  end 

  def has_nested_tables?
    doc = Nokogiri::HTML(self.html)       
    doc.xpath("//table/tr/td/table").count > 0 ? true : false
  end

  #take the phrases, break them down into single word items
  def assume_keywords_single_words
    self.assume_keywords.join(" ").split(" ").collect(&:downcase).uniq
  end  

  def path_term_score
    score = 0
    self.assume_keywords_single_words.each do |term|
      score = score +1 if self.path.downcase.include?(term)
    end
    score
  end

  def has_stats?
    self.text.include?("UA-") ? true : false
  end

  def caution_words
    words = []
    CAUTION_WORDS.each do |c|
      words << c if self.text.downcase.include?(c.downcase)
    end
    words
  end

  def calculate_depth
    self.depth = self.path.scan("/").count
  end

  def valid_page(link)
    invalids = %w".mp3 .jpg .mp4 .jpeg .bmp .doc .docx .pdf .js .json"

    return false if link.index("#") == 0
    return false if link.index("javascript") == 0
    return false if link.index("mailto") == 0
    return false if link.index("tel") == 0
    
    invalids.each do |i|
      return false if link.include?(i) 
    end    

    return true
  end
end
