class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def generate_name(hostnames)
    hostnames = hostnames.sort.join
    logger.info { hostnames }
    Digest::SHA1.hexdigest hostnames
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
end
