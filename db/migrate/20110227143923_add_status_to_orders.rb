# -*- encoding : utf-8 -*-
class AddStatusToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :status, :string, :default => 'new'
  end

  def self.down
    remove_column :orders, :status
  end
end
