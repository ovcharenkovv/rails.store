class HomeController < ApplicationController
  def index
    @products = Product.find_products_for_sale
  end
end
