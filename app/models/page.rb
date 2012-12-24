class Page < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id


  def title
    doc = Nokogiri::HTML(self.html)
    doc.xpath('//title').inner_html
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
    page_title.split("|").each{|a| a.strip}
    #page_title.each{|p|p.strip}
  end

  def path
    p = self.url.gsub("http://","")
    p = p.gsub("https://","")
    p.index("/").nil? ? "" : p[p.index("/"),2000]
  end

  def text
    doc = Nokogiri::HTML(self.html)
    doc.xpath('//text()').map{|e| e.to_s}.join(" ")
  end

  def find_phrase(phrase)
    text.scan(phrase).count
  end
end
