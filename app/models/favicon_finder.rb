class FaviconFinder
  # Try to parse the given document URL.
  # Return nil in case parsing fails (malformatted input URL).
  def initialize(source_url)
      begin
          @source_url = URI.parse(source_url)
          if @source_url.scheme == nil
              @source_url = URI.parse("http://" + source_url)
          end
      rescue
          return nil
      end

      @agent = Mechanize.new

      # TODO: fix mechanize meta refresh sleep bug!
      @agent.follow_meta_refresh = true
      @agent.keep_alive = false
      @agent.open_timeout = 15
      @agent.read_timeout = 15
      @agent.redirection_limit=10

      @agent.user_agent = "Friendly favicon fetcher (favicon.heroku.com)"
  end

  # Get the URL of the favicon.ico file.
  # First try to get it from the document source, if that fails try the default location.
  def url
      # Can we get the source of the document?
      begin
          # ugly workaround for broken mechanize follow_meta_refresh
          Timeout.timeout(15) { @page = @agent.get(@source_url.to_s) }
      rescue Timeout::Error => e
          return nil
      rescue => e
          return nil
      end
        
        

      # Get the first favicon link (in case there are many).
      # There can be many rel types for favicons: http://en.wikipedia.org/wiki/Favicon
      # Xpath doesn't have case insensitive match, so we use translate for that.
      favicon_href = @page.search("//link[translate(@rel, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'icon']/@href |" +
                                  "//link[translate(@rel, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'shortcut icon']/@href")[0].to_s

      # Try default location: http://domain.tld/favicon.ico
      # Before returning URL, check if the icon really exists.
      if favicon_href.empty?
          default_favicon_url = @page.uri.scheme + '://' + @page.uri.host + '/favicon.ico'
          if favicon_exists?(default_favicon_url)
              return default_favicon_url
          else
              return nil
          end
      end

      if URI.parse(favicon_href).relative?
          favicon_url = @page.uri.scheme + '://' + @page.uri.host + favicon_href
      else
          favicon_url = favicon_href
      end

      if favicon_exists?(favicon_url)
          return favicon_url
      else
          return nil
      end
  end

  private

  # Check if a favicon.ico file exists by downloading it and checking the file type
  def favicon_exists?(favicon_url)
      begin
          favicon = @agent.get(favicon_url)
      rescue
          return false
      end

      # check if it's a icon/gif/png file by looking at magic bytes
      if favicon.body =~ /^\x00\x00\x01\x00/ or 
         favicon.body =~ /^\x47\x49\x46\x38/ or
         favicon.body =~ /^\x89\x50\x4E\x47\x0D\x0A\x1A\x0A/
          return true
      else
          return false
      end
  end
end