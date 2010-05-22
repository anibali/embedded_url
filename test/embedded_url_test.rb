require 'test_helper'

class EmbeddedURLTest < Test::Unit::TestCase
  context "EmbeddedURL.embed" do
    context "when URL is irrelevant" do
      should "return nil" do
        assert_nil EmbeddedURL.embed("http://www.example.com/")
      end
    end
    
    context "when URL is relevant" do
      should "return a string containing appropriate markup" do
        url = "http://www.youtube.com/watch?v=xhUrRTh-b28"
        result = EmbeddedURL.embed(url)
        assert_kind_of String, result # Should be a String
        assert_not_equal "", result   # Shouldn't be empty
        assert_equal EmbeddedURL::YouTube.new(url).to_embedded, result
      end
    end
  end
end

