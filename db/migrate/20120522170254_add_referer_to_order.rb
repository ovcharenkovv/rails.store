class AddRefererToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :referer, :text
  end

  def self.down
    remove_column :orders, :referer
  end
end
