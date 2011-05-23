class AddIsPublishToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :is_publish, :boolean , :default => true
  end

  def self.down
    remove_column :products, :is_publish
  end
end
