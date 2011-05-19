class AddOrderingToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :ordering, :integer
  end

  def self.down
    remove_column :categories, :ordering
  end
end
