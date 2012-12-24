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


  end
end
