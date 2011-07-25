class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title, :limit => 50, :default => "" 
      t.string :user_name, :limit => 50, :default => ""
      t.string :user_email, :limit => 50, :default => ""
      t.text :comment
      t.integer :rating
      t.boolean :published, :default => true
      t.references :commentable, :polymorphic => true
      t.references :user
      t.timestamps
    end

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
    add_index :comments, :user_id
  end

  def self.down
    drop_table :comments
  end
end
