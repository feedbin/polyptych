class Favicon < ActiveRecord::Base
  attr_accessible :content_type, :favicon, :hostname

  has_many :favicon_panels
  has_many :panels, through: :favicon_panels
end
