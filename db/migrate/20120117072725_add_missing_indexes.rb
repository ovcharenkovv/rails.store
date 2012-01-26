# -*- encoding : utf-8 -*-
class AddMissingIndexes < ActiveRecord::Migration
  def self.up

    # These indexes were found by searching for AR::Base finds on your application
    # It is strongly recommanded that you will consult a professional DBA about your infrastucture and implemntation before
    # changing your database in that matter.
    # There is a possibility that some of the indexes offered below is not required and can be removed and not added, if you require
    # further assistance with your rails application, database infrastructure or any other problem, visit:
    #
    # http://www.railsmentors.org
    # http://www.railstutor.org
    # http://guides.rubyonrails.org


    add_index :posts, :post_category_id
    add_index :line_items, :order_id
    add_index :line_items, :cart_id
    add_index :line_items, :product_id
    add_index :categories, :parent_id
    add_index :products, :author_id
    add_index :products, :category_id
    add_index :users, :author_id
  end

  def self.down
    remove_index :posts, :post_category_id
    remove_index :line_items, :order_id
    remove_index :line_items, :cart_id
    remove_index :line_items, :product_id
    remove_index :categories, :parent_id
    remove_index :products, :author_id
    remove_index :products, :category_id
    remove_index :users, :author_id
  end

end
