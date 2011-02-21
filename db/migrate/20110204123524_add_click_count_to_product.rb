class AddClickCountToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :click_count, :integer
  end

  def self.down
    remove_column :products, :click_count
  end
end
