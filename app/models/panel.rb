class Panel < ActiveRecord::Base

  validates_uniqueness_of :name

  attr_accessible :name
  
  has_many :favicon_panels
  has_many :favicons, through: :favicon_panels

  def to_param
    name
  end
          
end
