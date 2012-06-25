class AddSalesCountAndProductCountAndRateToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :sales_count, :integer, :default => 0
    add_column :authors, :products_count, :integer, :default => 0
    add_column :authors, :rate, :integer, :default => 0
  end

  def self.down
    remove_column :authors, :rate
    remove_column :authors, :products_count
    remove_column :authors, :sales_count
  end
end
