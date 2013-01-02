require 'spec_helper'

describe "PageUrls" do
  describe "set page and path" do


    it "path equals /about/company" do
      p = Page.new
      p.url = "https://localhost:3000/about/company"
      p.path == "/about/company" ? true : raise('about/company not found')
    end

    it "path equals /about/company.aspx" do
      p = Page.new
      p.url = "https://localhost:3000/about/company.aspx"
      p.path == "/about/company.aspx" ? true : raise('about/company not found')
    end

    it "path equals localhost" do
      p = Page.new
      p.url = "http://localhost:3000"
      p.path == "" ? true : raise('about/company not found')
    end

    it "url path is NOT too complex, slashes" do
      p = Page.new
      p.url = "http://localhost:3000/services/search-engine-optimization"
      p.path_too_complex? == false ? true : raise(' too complex ')
    end

    it "url path is NOT too complex slashes and hyphens 3 slash" do
      p = Page.new
      p.url = "http://localhost:3000/services/web-development/ruby-on-rails/portfolio"
      p.path_too_complex? == false ? true : raise(' too complex ')
    end

    it "url path IS too complex 4 / " do
      p = Page.new
      p.url = "http://localhost:3000/services/web-development/ruby-on-rails/portfolio/x"
      p.path_too_complex? == true ? true : raise(' too complex ')
    end

    it "url path IS too complex, ? and ampersands" do
      p = Page.new
      p.url = "http://localhost:3000/?var=1&var=2&var=3"
      p.path_too_complex? == true ? true : raise(' too complex ')
    end

    it "url path IS too complex, longer than 60" do
      p = Page.new
      p.url = "http://localhost:3000/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
      p.path_too_complex? == true ? true : raise(' too complex ')
    end

    it "path contains assumed keywords" do
      page = Page.new
      page.html = '<html><head><meta name="description" content="not me"/><meta name="keywords" content="keyword1, keyword2 , keyword3 phrase3" /><title>Michigan Web Design | DotNetNuke Consulting | Web Ascender</title></head><body><h1>Michigan\'s Web Design Company</h1><h2>Web Design</h2><h2>Web Development</h2><strong>east lansing web design</strong><b>lansing web design</b></body></html>'
      page.url = "http://localhost:3000/services/web-development/ruby-on-rails/web-design/lansing/michigan/portfolio/x"
      page.path_term_score > 3 ? true : raise("path doesn't contain keywords")
    end


  end
end
