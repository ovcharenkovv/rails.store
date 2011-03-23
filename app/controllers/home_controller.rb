class HomeController < ApplicationController
  def index
    SitemapGenerator::Generator.run

    @top_products = Product.find_top_products(12)
    @new_products = Product.find_new_products(6)
    @hot_products = Product.find_hot_products(3)
  end
end
