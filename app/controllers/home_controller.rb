class HomeController < ApplicationController
  def index
    @top_products = Product.find_top_products(16)
    @new_products = Product.find_new_products(14)
    @random_products = Product.find_random_products(20,@top_products+@new_products)
  end
end
