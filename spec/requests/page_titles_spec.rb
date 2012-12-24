require 'spec_helper'


describe "PageTitles" do
  describe "title complexity" do

    it "find basic title" do
      page = Page.new
      page.html = "<html><title>Hello World</title></html>"
      "Hello World" == page.title ? true : raise('Title not found')
    end

    it "returns empty if no title" do
      page = Page.new
      page.html = "<html><head>Hello World</head></html>"
      "" == page.title ? true : raise('Blank title not found')
    end

    it "title complexity" do
      page = Page.new
      page.html = "<html><title>Ninjas | Pirates | Company LLC</title></html>"
      3 == page.title_complexity_score ? true : raise('Title Complexity score')
    end

    it "determines title focus" do
      page = Page.new
      page.html = "<html><title>Ninjas | Pirates > Company LLC</title></html>"      
      title_array = ["Ninjas","Pirates","Company LLC"]      
      title_array.count == page.title_focus.count ? true : raise('Same amount of items')
      title_array[2] == "Company LLC" ? true : raise('Last item not the same')
    end    
  end
end
