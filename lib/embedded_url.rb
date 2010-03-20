require 'rubygems'
require 'httparty'

%w[gist slideshare youtube vimeo jamendo].each do |lib|
  require File.join(File.dirname(__FILE__), "embedded_url/#{lib}")
end

module EmbeddedURL
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods

    def with_embedded(field)
      
      define_method("embedded_#{field}") do

        link = send(field)
        
        begin
          Gist.new(link).to_embedded || 
            Youtube.new(link).to_embedded || 
            Vimeo.new(link).to_embedded || 
            SlideShare.new(link).to_embedded ||
            Jamendo.new(link).to_embedded ||
            (link =~ /^http/ ? link : "http://#{link}")
        rescue
        end
        
      end
      
    end

  end
end
