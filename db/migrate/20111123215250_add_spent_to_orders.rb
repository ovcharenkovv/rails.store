# -*- encoding : utf-8 -*-
class AddSpentToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :spent, :decimal
  end

  def self.down
    remove_column :orders, :spent
  end
end
