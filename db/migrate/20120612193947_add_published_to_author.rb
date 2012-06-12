class AddPublishedToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :published, :boolean, :default => true
  end

  def self.down
    remove_column :authors, :published
  end
end
