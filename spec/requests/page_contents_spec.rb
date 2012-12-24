require 'spec_helper'

describe "PageContents" do
  describe "core page PageContents" do
    it "strip content" do
      page = Page.new
      page.html = "<html><title>Hello World</title><body><h1>H1Content</h1><div>DivContent</div></body></html>"
      "Hello World H1Content DivContent" == page.text ? true : raise('Text strip')
    end

    it "has specific term density" do
      page = Page.new
      page.html = "<html><title>Hello World</title><body><h1>Hello dude</h1><div>That's awesome Hello</div></body></html>"

      3 == page.find_phrase("Hello") ? true : raise('Find phrase / density')
    end

  end
end
