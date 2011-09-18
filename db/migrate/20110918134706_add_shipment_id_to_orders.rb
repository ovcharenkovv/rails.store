class AddShipmentIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipment_id, :string
  end

  def self.down
    remove_column :orders, :shipment_id
  end
end
