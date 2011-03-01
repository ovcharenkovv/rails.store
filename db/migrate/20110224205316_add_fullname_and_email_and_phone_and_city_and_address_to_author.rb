class AddFullnameAndEmailAndPhoneAndCityAndAddressToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :fullname, :string
    add_column :authors, :email, :string
    add_column :authors, :phone, :string
    add_column :authors, :city, :string
    add_column :authors, :address, :string
  end

  def self.down
    remove_column :authors, :address
    remove_column :authors, :city
    remove_column :authors, :phone
    remove_column :authors, :email
    remove_column :authors, :fullname
  end
end
