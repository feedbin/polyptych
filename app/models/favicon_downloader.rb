require 'open-uri'

class FaviconDownloader
  
  attr_accessor :url, :hostname, :data, :content_type
  
  def initialize(hostname)
    @hostname = hostname
  end
  
  def download
    self.url = FaviconFinder.new(hostname).url
    
    unless url.nil?
      open(url) do |response|
        self.content_type = (response.content_type) ? response.content_type : 'image/x-icon'
        self.data = Base64.encode64(response.read).gsub("\n", '')
      end
    end
    
  end
  
end
