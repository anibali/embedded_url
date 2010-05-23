require 'test_helper'

class AmazonTest < Test::Unit::TestCase
  context "An EmbeddedURL::Amazon instance" do
    context "with an irrelevant URL" do
      setup do
        @amazon = EmbeddedURL::Amazon.new "http://www.example.com/"
      end
      
      should "return nil when sent #to_embedded" do
        assert_equal nil, @amazon.to_embedded
      end
    end
    
    context "with an irrelevant Amazon URL" do
      setup do
        @amazon = EmbeddedURL::Amazon.new "http://www.amazon.com/gp/help/customer/display.html"
      end
      
      should "return nil when sent #to_embedded" do
        assert_equal nil, @amazon.to_embedded
      end
    end
    
    context "with a relevant Amazon MP3 URL" do
      setup do
        @amazon = EmbeddedURL::Amazon.new "http://www.amazon.com/Happy-Child/dp/B000XRKF00"
      end
      
      should "return a string containing markup when sent #to_embedded" do
        result = @amazon.to_embedded
        assert_kind_of String, result # Should be a String
        assert_not_equal "", result   # Shouldn't be empty
      end
    end
    
    context "with a relevant (but messy) Amazon MP3 URL" do
      setup do
        @amazon = EmbeddedURL::Amazon.new "http://www.amazon.com/gp/product/B000XRKF00/ref=dm_dp_trk5"
      end
      
      should "return a string containing markup when sent #to_embedded" do
        result = @amazon.to_embedded
        assert_kind_of String, result # Should be a String
        assert_not_equal "", result   # Shouldn't be empty
      end
    end
  end
end

