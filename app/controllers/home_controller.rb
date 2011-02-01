class HomeController < ApplicationController
  def index
    if params[:category]
      @products = Product.find_products_by_category(params[:category],params[:page])
    else
      if params[:author]
        @products = Product.find_products_by_author(params[:author],params[:page])
      else
        @products = Product.find_products_for_sale(params[:page])
      end
    end
  end
end
