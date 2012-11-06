class Panel < ActiveRecord::Base
  attr_accessible :name
  
  has_many :favicon_panels
  has_many :favicons, through: :favicon_panels
end
