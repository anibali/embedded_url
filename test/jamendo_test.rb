require 'test_helper'

class JamendoTest < Test::Unit::TestCase
  context "An EmbeddedURL::Jamendo instance" do
    context "with an irrelevant URL" do
      setup do
        @jamendo = EmbeddedURL::Jamendo.new "http://www.example.com/"
      end
      
      should "return nil when sent #to_embedded" do
        assert_equal nil, @jamendo.to_embedded
      end
    end
    
    context "with an irrelevant Jamendo URL" do
      setup do
        # Jamendo widget does not support playing all music by an artist,
        # therefore an artist URL is not appropriate for embedding
        @jamendo = EmbeddedURL::Jamendo.new "http://www.jamendo.com/en/artist/857"
      end
      
      should "return nil when sent #to_embedded" do
        assert_equal nil, @jamendo.to_embedded
      end
    end
    
    context "with a relevant Jamendo album URL" do
      setup do
        @jamendo = EmbeddedURL::Jamendo.new "http://www.jamendo.com/en/album/4240"
      end
      
      should "return a string containing markup when sent #to_embedded" do
        result = @jamendo.to_embedded
        assert_kind_of String, result # Should be a String
        assert_not_equal "", result   # Shouldn't be empty
      end
    end
    
    context "with a relevant Jamendo track URL" do
      setup do
        @jamendo = EmbeddedURL::Jamendo.new "http://www.jamendo.com/en/track/30067"
      end
      
      should "return a string containing markup when sent #to_embedded" do
        result = @jamendo.to_embedded
        assert_kind_of String, result # Should be a String
        assert_not_equal "", result   # Shouldn't be empty
      end
    end
  end
end

