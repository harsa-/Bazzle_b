class Post < ActiveRecord::Base
  # can't post empty messages
  validates_length_of :message, :minimum => 1
end
