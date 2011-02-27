class AddStatusToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :status, :string, :default => 'Есть в наличии'
  end

  def self.down
    remove_column :products, :status
  end
end
