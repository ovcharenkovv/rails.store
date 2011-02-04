class ProductsController < ApplicationController
  before_filter :get_category_or_author
  # GET /products
  # GET /products.xml

  def get_category_or_author
    if params[:category_id]
      @category = Category.find(params[:category_id])
    end
    if params[:author_id]
      @category = Author.find(params[:author_id])
    end

  end

  def index
    @products = @category.products.paginate :page=>params[:page], :order=>'created_at desc', :per_page => 6

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = @category.products.find(params[:id])

    @product.inc_click

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @product }
    end
  end
end
