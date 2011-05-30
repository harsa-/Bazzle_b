class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  before_filter :prepare_for_mobile
  
  private
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?
  
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
  # splits too long words after max chars with invisible "zero-length-space"
  # UTF8 char that should display in all browsers
  # http://www.fileformat.info/info/unicode/char/200b/index.htm
  # source: http://grosser.it/2009/08/30/unobstrusive-word_wrap-aka-split_after-for-ruby-rails/
  def split_after(max, options={})
    zero_length_space = '​' #aka ​
    options[:with] ||= zero_length_space

    split(/ /).map do |part|
      part = part.mb_chars
      if part.length > max
        part[0...max] + options[:with] + part[max..-1].to_s.split_after(max)
      else
        part
      end
    end * ' '
  end
end
