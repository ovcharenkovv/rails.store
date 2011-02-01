class AddAuthorIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :author_id, :integer
  end

  def self.down
    remove_column :products, :author_id
  end
end
