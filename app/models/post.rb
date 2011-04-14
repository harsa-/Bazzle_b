class Post < ActiveRecord::Base
  belongs_to :channel
  # can't post empty messages
  validates_length_of :message, :minimum => 1
  validates :channel_name, :presence => true
  
  def can_destroy?(session_id)
    return (self.session_id.eql? session_id and self.created_at > Time.now.ago(60))
  end
  
  def seconds_remaining
    return (Time.now - post.created_at).to_int
  end
end