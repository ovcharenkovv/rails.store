# -*- encoding : utf-8 -*-
class AddAuthorPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :author_price, :decimal
  end

  def self.down
    remove_column :products, :author_price
  end
end
