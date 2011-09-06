class HomeController < ApplicationController
  def index
  end

  def show

    case params[:slug]
      when 'top'
        @title="30 популярных товаров"
        @products = Product.find_top_products(30)
      when 'new'
        @title="30 новинок"
        @products = Product.find_new_products(30)
      when 'rnd'
        @title="30 случаных товаров"
        @products = Product.find_random_products(30,'')
      else
        @product_title=""
        @products = Product.find_new_products(30) 
    end

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @products }
    end
  end

end
