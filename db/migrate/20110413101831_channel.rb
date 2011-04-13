class Channel < ActiveRecord::Migration
  def self.up
    create_table :channels do |t|
    t.text :name, :limit => 1000
    
      t.timestamps
    end
  end

    def self.down
      drop_table :channels
    end
  end
