class AddSessionIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :session_id, :text
  end

  def self.down
    remove_column :posts, :session_id
  end
end
