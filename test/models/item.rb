class Item < ActiveRecord::Base
  include EmbeddedURL
  
  with_embedded 'url'
end
