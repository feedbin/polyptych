class FaviconCreator
  @queue = :favicons_queue
  def self.perform(favicon_id)
    favicon = Favicon.find(favicon_id)
    
    favicon_result = FaviconDownloader.new(favicon.hostname)
    favicon_result.download
    
    if favicon_result.data && favicon_result.data.length > 0
      favicon.update_attributes(favicon: favicon_result.data, content_type: favicon_result.content_type)
    end
    
  end
end