class AddPublishProfileToAuthors < ActiveRecord::Migration
  def self.up
    add_column :authors, :publish_profile, :boolean, :default => false
  end

  def self.down
    remove_column :authors, :publish_profile
  end
end
