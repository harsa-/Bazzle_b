class AddNameToChannel < ActiveRecord::Migration
  def self.up
    add_column :channels, :name, :string, :limit => 100
  end

  def self.down
    remove_column :channels, :name
  end
end
