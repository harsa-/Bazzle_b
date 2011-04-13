class Channel < ActiveRecord::Base
  has_many :posts
  has_friendly_id :name, :use_slug => true
  
end
