# -*- encoding : utf-8 -*-
class AddIsHotToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :is_hot, :boolean
  end

  def self.down
    remove_column :products, :is_hot
  end
end
