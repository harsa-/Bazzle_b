class Posts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :message
      t.text :channel_id
      t.text :channel_name
      t.text :session_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end

