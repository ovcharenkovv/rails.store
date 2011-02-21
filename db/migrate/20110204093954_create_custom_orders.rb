class CreateCustomOrders < ActiveRecord::Migration
  def self.up
    create_table :custom_orders do |t|
      t.string :name
      t.text :description
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_orders
  end
end
