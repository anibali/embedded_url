require 'uri'

# Iterate through libraries which add a type of embedded url and require
# each one from the "embedded_url" folder
%w[gist slideshare youtube vimeo jamendo].each do |lib|
  require File.join(File.dirname(__FILE__), "embedded_url", lib)
end

# Include this module in an ActiveRecord model to enable access to the features
# of Embedded URL (this is done automatically when using Rails).
module EmbeddedURL
  def self.included(base)
    # Add methods of ClassMethods as class methods of `base`
    base.extend(ClassMethods)
  end
  
  # Returns HTML for embedding media represented by the URL or nil if
  # site is not recognised
  def self.embed(url, options={})
    html = nil
    
    # Iterate through each class representing a type of embedded object and
    # attempt to embed link
    [Gist, YouTube, Vimeo, SlideShare, Jamendo].each do |clazz|
      html ||= clazz.new(url).to_embedded(options) rescue nil
    end
    
    return html
  end
  
  # Methods in this module will be added as class methods to any object which
  # includes EmbeddedURL.
  module ClassMethods
    # Call this method to specify an attribute to be embedded, like so:
    #  class Post < ActiveRecord::Base
    #    with_embedded :link
    #  end
    #
    # Now the HTML for the embedded URL may be obtained as follows:
    #  @post.embedded_link
    #
    # Note: if Embedded URL does not recognize the link then the original value
    # is returned (prefixed with 'http://' if necessary).
    def with_embedded(field, options={})
      # Add instance method
      define_method("embedded_#{field}") do
        # Obtain url from the appropriate record field
        url = send(field)
        return_value = EmbeddedURL.embed(url, options)
        
        # If we can't embed the address, return it as a full URL
        uri = URI.parse url
        return_value ||= (uri.scheme.nil? ? "http://#{url}" : url)
        
        return return_value
      end
    end # End with_embedded
  end # End ClassMethods
end # End EmbeddedURL
