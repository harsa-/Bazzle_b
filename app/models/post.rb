class Post < ActiveRecord::Base
  belongs_to :channel
  # can't post empty messages
  validates_length_of :message, :minimum => 1
  validates :channel_id, :presence => true
end
