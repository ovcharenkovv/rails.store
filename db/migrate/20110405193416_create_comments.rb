class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :body
      t.boolean :publish
      t.integer :rating
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
