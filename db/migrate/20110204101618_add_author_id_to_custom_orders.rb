class AddAuthorIdToCustomOrders < ActiveRecord::Migration
  def self.up
    add_column :custom_orders, :author_id, :integer
  end

  def self.down
    remove_column :custom_orders, :author_id
  end
end
