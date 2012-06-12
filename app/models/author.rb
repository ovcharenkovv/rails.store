# -*- encoding : utf-8 -*-
class Author < ActiveRecord::Base
  has_many :products, :dependent => :delete_all
  has_one :user

  validates :name, :presence => true
  validates :name, :uniqueness => true

  def self.top_masters quantity
    includes(:products).where(:published => true).where('products.published is not false').group("products.author_id").order("count(products.id) DESC ").limit(quantity)
  end

end
