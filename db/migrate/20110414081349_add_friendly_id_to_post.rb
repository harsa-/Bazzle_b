class AddFriendlyIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :channel_name, :text
  end

  def self.down
    remove_column :posts, :channel_name
  end
end
