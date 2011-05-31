module ApplicationHelper
  
  # splits too long words after max chars with invisible "zero-length-space"
  # UTF8 char that should display in all browsers
  # http://www.fileformat.info/info/unicode/char/200b/index.htm
  # source: http://grosser.it/2009/08/30/unobstrusive-word_wrap-aka-split_after-for-ruby-rails/
  def split_string_after(string, max, options={})
    zero_length_space = '​' #aka ​
    options[:with] ||= zero_length_space

    string.split(/ /).map do |part|
      part = part.mb_chars
      if part.length > max
        part[0...max] + options[:with] + part[max..-1].to_s.split_after(max)
      else
        part
      end
    end * ' '
  end
end
