require "embedded_url"

# Automatically add Embedded URL functionality to ActiveRecord models in Rails
ActiveRecord::Base.class_eval do
  include EmbeddedURL
end

