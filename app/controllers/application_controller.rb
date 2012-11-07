class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def generate_name(hostnames)
    Digest::SHA1.hexdigest hostnames.sort.join
  end
end
