class HomeController < ApplicationController
  def index
    @top_products = Product.find_top_products(18)
    @new_products = Product.find_new_products(18)
    @hot_products = Product.find_hot_products(3)
  end
end
