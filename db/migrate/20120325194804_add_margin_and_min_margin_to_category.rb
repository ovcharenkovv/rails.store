class AddMarginAndMinMarginToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :margin, :integer , :default => 35
    add_column :categories, :min_margin, :integer , :default => 15
  end

  def self.down
    remove_column :categories, :min_margin
    remove_column :categories, :margin
  end
end
