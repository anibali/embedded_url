module EmbeddedURL
class Jamendo
  attr_accessor :url
  
  def initialize(url)
    self.url = url
  end
  
  def to_embedded
    if url.match /jamendo.com\/(.*)\/(.*)\/(\d*)/
      lang = $1 # Language (eg "en")
      type = $2 # Type (eg "track", "album")
      id = $3   # ID
      "<object width=\"200\" height=\"300\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0\" align=\"middle\"><param name=\"allowScriptAccess\" value=\"always\" /><param name=\"wmode\" value=\"transparent\" /><param name=\"movie\" value=\"http://widgets.jamendo.com/#{lang}/#{type}/?playertype=2008&#{type}_id=#{id}\" /><param name=\"quality\" value=\"high\" /><param name=\"bgcolor\" value=\"#FFFFFF\" /><embed src=\"http://widgets.jamendo.com/#{lang}/#{type}/?playertype=2008&#{type}_id=#{id}\" quality=\"high\" wmode=\"transparent\" bgcolor=\"#FFFFFF\" width=\"200\" height=\"300\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\">&nbsp;</embed>&nbsp;</object>"
    end
  end
end
end
