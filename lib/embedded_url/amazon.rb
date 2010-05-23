module EmbeddedURL
  
  class Amazon
    attr_accessor :url
    
    def initialize(url)
      self.url = url
    end
    
    def to_embedded(options={})
      if url =~ /amazon\.com/
        asin = url.split("/").last
        asin = url.split("/")[-2] if asin.include? '='
        unless asin.include? '.'
          options = {
            :width => 234,
            :height => 60,
            :tag => 'mush01-20'
          }.merge options
          <<END
<script type='text/javascript'>
  //<![CDATA[
    var amzn_wdgt={widget:'MP3Clips'};
    amzn_wdgt.tag='#{options[:tag]}';
    amzn_wdgt.widgetType='ASINList';
    amzn_wdgt.ASIN='#{asin}';
    amzn_wdgt.width='#{options[:width]}';
    amzn_wdgt.height='#{options[:height]}';
    amzn_wdgt.shuffleTracks='True';
    amzn_wdgt.marketPlace='US';
  //]]>
</script>

<script src='http://wms.assoc-amazon.com/20070822/US/js/swfobject_1_5.js' type='text/javascript'></script>
END
        end
      end
    end # End to_embedded
  end # End Amazon
  
end

