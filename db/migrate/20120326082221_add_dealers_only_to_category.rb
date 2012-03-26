class AddDealersOnlyToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :dealers_only, :boolean , :default => false
  end

  def self.down
    remove_column :categories, :dealers_only
  end
end
