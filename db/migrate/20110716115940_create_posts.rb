class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :meta_k
      t.string :meta_d
      t.string :master
      t.integer :rating
      t.integer :post_category_id
      t.boolean :can_comment , :default => true
      t.boolean :present_footer , :default => true
      t.text :short_body
      t.text :body
      t.string :slug

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
