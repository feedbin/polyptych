module FaviconsHelper
  def favicon_content_type(content_type)
    if /image/ =~ content_type
      content_type
    else
      'image/x-icon'
    end
  end
end
