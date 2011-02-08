class HomeController < ApplicationController
  def index
    @top_products = Product.find_top_products(9)
    @hot_products = Product.find_hot_products(3)
  end
end
