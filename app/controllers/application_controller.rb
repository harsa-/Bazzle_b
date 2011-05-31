class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  def is_number?(object)
    true if Float(object) rescue false
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
end
