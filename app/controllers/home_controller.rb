class HomeController < ApplicationController
  def index
    @products = Product.find_products_for_sale(params[:page],6)
  end
end
