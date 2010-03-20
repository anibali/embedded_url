require 'rubygems'
require 'httparty'
require 'uri'

# Iterate through libraries which add a type of embedded url and require
# each one from the "embedded_url" folder
%w[gist slideshare youtube vimeo jamendo].each do |lib|
  require File.join(File.dirname(__FILE__), "embedded_url", lib)
end

module EmbeddedURL
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def with_embedded(field)
      # Add instance method
      define_method("embedded_#{field}") do
        # Obtain link from the appropriate record field
        link = send(field)
        
        return_value = nil
        
        # Iterate through each class representing a type of embedded object and
        # attempt to embed link
        [Gist, Youtube, Vimeo, SlideShare, Jamendo].each do |clazz|
          (return_value ||= clazz.new(link).to_embedded) rescue Exception
        end
        
        # If we can't embed the link, return it as a full URL
        uri = URI.parse link
        return_value ||= (uri.scheme.nil? ? "http://#{link}" : link)
        
        return_value
      end
    end # End with_embedded
  end # End ClassMethods
end # End EmbeddedURL
