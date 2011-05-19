class AddDescriptionToChannel < ActiveRecord::Migration
  def self.up
    add_column :channels, :description, :text
  end

  def self.down
    remove_column :channels, :description
  end
end
