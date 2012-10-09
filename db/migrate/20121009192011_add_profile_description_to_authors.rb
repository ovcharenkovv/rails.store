class AddProfileDescriptionToAuthors < ActiveRecord::Migration
  def self.up
    add_column :authors, :profile_description, :string
  end

  def self.down
    remove_column :authors, :profile_description
  end
end
