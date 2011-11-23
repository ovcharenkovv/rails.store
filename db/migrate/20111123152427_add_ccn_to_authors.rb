class AddCcnToAuthors < ActiveRecord::Migration
  def self.up
    add_column :authors, :ccn, :string
  end

  def self.down
    remove_column :authors, :ccn
  end
end
