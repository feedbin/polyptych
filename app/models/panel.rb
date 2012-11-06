class Panel < ActiveRecord::Base
  attr_accessible :hash
  has_many :favicons, through: :favicon_panels
end
