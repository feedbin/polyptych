class Panel < ActiveRecord::Base
  attr_accessible :name
  
  has_many :favicon_panels
  has_many :favicons, through: :favicon_panels
  
  def generate_name
    hostnames = favicons.order('favicons.hostname').pluck(:hostname).join
    self.name = Digest::SHA1.hexdigest hostnames
  end
  
  def to_param
    "#{self.name.parameterize}"
  end

end
