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

    it "doesnt crash when not found - term density" do
      page = Page.new
      page.html = "<html><title>Hello World</title><body><h1>Hello dude</h1><div>That's awesome Hello</div></body></html>"
      0 == page.find_phrase("Ninja") ? true : raise('Find phrase / density')
    end

    it "counts title density" do
      page = Page.new
      page.html = "<html><title>Hello | World</title><body><h1>Hello dude World</h1><div>That's awesome Hello</div></body></html>"
      3 == page.title_density ? true : raise('Title density calculation')
    end

    it "2 h1s" do
      page = Page.new
      page.html = "<html><title>Hello World</title><body><h1>Hello dude</h1><h1>fine man</h1><div>That's awesome Hello</div></body></html>"
      2 == page.h1s.count ? true : raise('h1s not found')
    end

    it "assumes keywords" do
      page = Page.new
      page.html = '<html><head><meta name="description" content="not me"/><meta name="keywords" content="keyword1, keyword2 , keyword3 phrase3" /><title>Michigan Web Design | DotNetNuke Consulting | Web Ascender</title></head><body><h1>Michigan\'s Web Design Company</h1><h2><a href="#">Web Design</a></h2><h2>Web Development</h2><strong>east lansing web design</strong><b>lansing web design</b></body></html>'
      #puts page.assume_keywords
      page.assume_keywords.include?("keyword3 phrase3") ? true : raise('keyword3 phase3 not found')
      page.assume_keywords.include?("DotNetNuke Consulting") ? true : raise("DotNetNuke Consulting not found")
      page.assume_keywords.include?("Web Design") ? true : raise("web design")    
      !page.assume_keywords.include?("not me") ? true : raise("should not be included")
    end

    it "breaks assume keywords into simple terms" do
      page = Page.new
      page.html = '<html><head><meta name="description" content="not me"/><meta name="keywords" content="keyword1, keyword2 , keyword3 phrase3" /><title>Michigan Web Design | DotNetNuke Consulting | Web Ascender</title></head><body><h1>Michigan\'s Web Design Company</h1><h2>Web Design</h2><h2>Web Development</h2><strong>east lansing web design</strong><b>lansing web design</b></body></html>'
      #puts page.assume_keywords_single_words
      page.assume_keywords_single_words.include?("development") ? true : raise("should include development")
    end

    it "has 3 tables" do
      page = Page.new
      page.html = "<html><head></head><body><table><tr><td></td></tr></table><table><tr><td><table><tr><td></td></tr></table></td></tr></table></body></html>"
      page.tables.count == 3 ? true : raises("page doesn't have 3 tables")
    end


    it "has 0 tables" do
      page = Page.new
      page.html = "<html><head></head></html>"
      page.tables.count == 0 ? true : raises("page doesn't have 0 tables")
    end

    it "finds nested tables" do
      page = Page.new
      page.html = "<html><head></head><body><table><tr><td><table><tr><td></td></tr></table></td></tr></table><table><tr><td><table><tr><td><table><tr><td><table><tr><td></td></tr></table></td></tr></table></td></tr></table></td></tr></table></body></html>"

      true == page.has_nested_tables? ? true : raise('finds nested tables')
    end

    it "has internal linking" do
      page = Page.new
      page.url = "http://www.webascender.com/whatever/hello.html"
      page.html = '<html><body><a href="http://www.google.com/somewhere">Google</a><ul class="html"><li><a href="http://www.webascender.com/full_url.html">Hello</a></li><li><a href="/with_slash.html">Hello</a></li><li><a href="no_slash.html">Hello</a></li></ul></body></html>'      
      page.internal_links.count == 3 ? true : raises('has internal linking')
    end

    it "has internal linking with domain in url" do
      page = Page.new
      page.url = "http://www.webascender.com/whatever/URL.html"
      page.html = '<html><body><a href="#anchor.html">Anchor</a><a href="http://www.google.com/somewhere?www.webascender.com">Google</a><ul class="html"><li><a href="http://www.webascender.com/full_url.html">Hello</a></li><li><a href="/with_slash.html">Hello</a></li><li><a href="no-slash.html">Hello</a><a href="mailto:">Mail To</a></li></ul></body></html>'      
      page.internal_links.count == 3 ? true : raises('has internal linking in domain')
    end    

    it "has external linking" do
      page = Page.new
      page.url = "http://www.webascender.com/whatever/hello.html"
      page.html = '<html><body><a href="http://www.google.com/somewhere">Google</a><ul class="html"><li><a href="http://www.webascender.com/hello.html">Hello</a></li><li><a href="/hello.html">Hello</a></li><li><a href="hello.html">Hello</a></li></ul></body></html>'      
      page.external_links.count == 1 ? true : raises('has external linking')
    end

    it "has caution word" do
      page = Page.new
      page.url = "http://www.webascender.com/whatever/hello.html"
      page.html = '<html><body><a href="http://www.google.com/somewhere">Google</a>Link Exchange<ul class="html"><li><a href="http://www.webascender.com/hello.html">Hello</a></li><li><a href="/hello.html">Hello</a></li><li><a href="hello.html">Hello</a></li></ul></body></html>'      
      page.caution_words.count == 1 ? true : raises('caution words')
    end


    it "has  links" do
      page = Page.new
      page.url = "http://www.webascender.com/whatever/hello.html"
      page.html = '<html><body><a href="http://www.google.com/somewhere">Google</a><ul class="html"><li><a href="http://www.webascender.com/hello.html">Hello</a></li><li><a href="/hello.html">Hello</a></li><li><a href="hello.html">Hello</a></li></ul></body></html>'      
      page.links.count == 4 ? true : raises('has links ')
    end

    it "has  domain" do
      page = Page.new
      page.url = "http://www.webascender.com/whatever/hello.html"
      page.html = '<html><body><a href="http://www.google.com/somewhere">Google</a><ul class="html"><li><a href="http://www.webascender.com/hello.html">Hello</a></li><li><a href="/hello.html">Hello</a></li><li><a href="hello.html">Hello</a></li></ul></body></html>'      
      page.domain == "www.webascender.com" ? true : raises('has site ')
    end

    it "has  domain root" do
      page = Page.new
      page.url = "http://www.webascender.com"
      page.html = '<html><body><a href="http://www.google.com/somewhere">Google</a><ul class="html"><li><a href="http://www.webascender.com/hello.html">Hello</a></li><li><a href="/hello.html">Hello</a></li><li><a href="hello.html">Hello</a></li></ul></body></html>'      
      puts page.domain
      page.domain == "www.webascender.com" ? true : raises('has site root')
    end


    it "has image alt tags" do
      page = Page.new
      page.html = '<html><img src="#"/><img src="#"><img src="#" alt="ninja kittens"/><img src="#" alt=""></html>'
      page.image_count == 4 ? true : raises("image count not working")
    end

    it "returns alt image text" do
      page = Page.new
      page.html = '<html><img src="#"/><img src="#"><img src="#" alt="ninja kittens"/><img src="#" alt=""></html>'
      page.alt_image_text.include?("ninja kittens") ? true : raises("alt text has ninja kittens")
    end

    it "has images" do
      page = Page.new
      page.html = '<html><img src="hello-world.jpg"/><img src="ninja-kittens.jpg"><img src="#" alt="wizard-magic.png"/><img src="?whatever&it-is" alt=""></html>'
     # puts page.image_names
      page.image_names.first.include?("hello-world.jpg") ? true : raises("image name has ninja kittens")
    end

    it "counts image density" do
      page = Page.new
      page.html = '<html><title>Hello | World | Wizard</title><body><h1>Hello dude World</h1><div>awesome Hello</div><img src="hello-world.jpg"/><img src="ninja-kittens.jpg"><img src="#" alt="wizard-magic.png"/><img src="?whatever&it-is" alt=""></body></html>'
      #puts page.image_name_density
      2 == page.image_name_density ? true : raise('Title density calculation')
    end


    it "determines too much on page javascript" do
      page = Page.new
      page.html = '<html><script type="text/javascript">$(document).ready(function(){$("h1").show();}); alert("hello");</script><style type="text/css">h2{border:0px}</style><div>hi</div><script type="text/javascript">alert("hello 2");</script></html>'
      page.javascript_too_complex?(50) ? true : raises("too complex of javascript")
    end

    it "determines too much on page css" do
      page = Page.new
      page.html = '<html><script type="text/javascript">$(document).ready(function(){$("h1").show();}); alert("hello");</script><style type="text/css">h2{border:0px;padding:0px;color:#000000;}</style><div>hi</div><script type="text/javascript">alert("hello 2");</script></html>'
      page.css_too_complex?(40) ? true : raises("too complex of css")
    end

    it "determines too many words on the page" do
      page = Page.new
      page.html = '<html><head><meta name="description" content="not me"/><meta name="keywords" content="keyword1, keyword2 , keyword3 phrase3" /><title>Michigan Web Design | DotNetNuke Consulting | Web Ascender</title></head><body><h1>Michigan\'s Web Design Company</h1><h2>Web Design</h2><h2>Web Development</h2><strong>east lansing web design</strong><b>lansing web design</b>hello there how are you?</body></html>'
      page.too_many_words?(10) ? true : raises(" too many words ")
    end


    it "has stats engine" do
      page = Page.new
      page.html = '<html><head><meta name="description" content="not me"/><meta name="keywords" content="keyword1, keyword2 , keyword3 phrase3" /><title>Michigan Web Design | DotNetNuke Consulting | Web Ascender</title></head><body><h1>Michigan\'s Web Design Company</h1><h2>Web Design</h2><h2>Web Development</h2><strong>east lansing web design</strong><b>lansing web design</b>hello there how are you? _uacct = "UA-195975-1";
 </body></html>'
      page.has_stats? ? true : raises(" has stats ")
    end


    it "too many inline styles" do
      page = Page.new
      page.html = '<html><head><meta name="description" content="not me"/><meta name="keywords" content="keyword1, keyword2 , keyword3 phrase3" /><title>Michigan Web Design | DotNetNuke Consulting | Web Ascender</title></head><body><h1>Michigan\'s Web Design Company</h1><h2 style="border:1px;">Web Design</h2><h2>Web Development</h2><strong style="border:1px">east lansing web design</strong><b style="border:1px">lansing web design</b>hello there how are you?</body></html>'
      page.inline_style_count == 3 ? true : raises("3 inline styles")
      page.too_many_inline_styles?(1) ? true : raises(" too many inline styles ")
    end


    it "appears to have li navigation" do
      page = Page.new
      page.html = '<html><body><ul class="html"><li><a href="/hello.html">Hello</a></li><li><a href="/hello.html">Hello</a></li><li><a href="/hello.html">Hello</a></li></ul></body></html>'
      page.li_link_count == 3 ? true : raises("link count 3")
    end
  end
end
