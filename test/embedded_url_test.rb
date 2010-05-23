require 'test_helper'

class EmbeddedURLTest < Test::Unit::TestCase
  context "EmbeddedURL.embed" do
    context "when URL is unrecognised" do
      should "return nil" do
        assert_nil EmbeddedURL.embed("http://www.example.com/")
      end
    end
    
    context "when URL is recognised" do
      should "return a string containing appropriate markup" do
        url = "http://www.youtube.com/watch?v=xhUrRTh-b28"
        result = EmbeddedURL.embed(url)
        assert_kind_of String, result # Should be a String
        assert_not_equal "", result   # Shouldn't be empty
        assert_equal EmbeddedURL::YouTube.new(url).to_embedded, result
      end
    end
  end
  
  context "A model with an embedded 'url' field containing an unrecognised URL" do
    setup do
      Item.delete_all
      @url = "http://www.example.com/"
      @item = Item.new :url => @url
      @item.save!
    end
    
    should "return the URL when sent #embedded_url" do
      assert_equal @url, @item.embedded_url
    end
  end
  
  context "A model with an embedded 'url' field containing a recognised URL" do
    setup do
      Item.delete_all
      @url = "http://www.youtube.com/watch?v=xhUrRTh-b28"
      @item = Item.new :url => @url
      @item.save!
    end
    
    should "return a string containing appropriate markup when sent #embedded_url" do
      result = @item.embedded_url
      assert_kind_of String, result # Should be a String
      assert_not_equal "", result   # Shouldn't be empty
      assert_equal EmbeddedURL::YouTube.new(@url).to_embedded, result
    end
  end
end

