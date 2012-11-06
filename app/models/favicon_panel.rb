class FaviconPanel < ActiveRecord::Base
  attr_accessible :favicon_id, :panel_id
  
  belongs_to :favicon
  belongs_to :panel
end
