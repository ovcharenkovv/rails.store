# -*- encoding : utf-8 -*-
class Author < ActiveRecord::Base
  has_many :products, :dependent => :delete_all
  has_one :user

  validates :name, :presence => true
  validates :name, :uniqueness => true

  def self.top_masters quantity
    includes(:products).where("rate >= 9").order("rate DESC ").limit(quantity)
    #includes(:products).where(:published => true).where('products.published is not false').group("products.author_id").order("count(products.id) DESC ").limit(quantity)
  end

  def update_product_count
    self.update_attribute(:products_count, Product.author_products_count(self.id))
  end

  def update_sales_count
    self.update_attribute(:sales_count, self.sales_count += 1)
    self.update_rate
  end

  def update_rate
    self.update_attribute(:rate, self.sales_count.to_i + self.products_count.to_i)
  end

end
