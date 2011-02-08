class ProductsController < ApplicationController

  before_filter :get_category_or_author , :init_breadcrumb
  # GET /products
  # GET /products.xml

  def init_breadcrumb
    if params[:category_id]
      add_breadcrumb "Categories", :categories_path
      add_breadcrumb "Products", :category_products_path

    end
    if params[:author_id]
      add_breadcrumb "Authors", :authors_path
      add_breadcrumb "Products", :author_products_path
    end
  end

  def get_category_or_author
    if params[:category_id]
      @category = Category.find(params[:category_id])
    end
    if params[:author_id]
      @category = Author.find(params[:author_id])
    end
  end

  def index
    session[:product_params]=params
    if params[:sort]=='popularity'
      @products = @category.products.paginate :page=>params[:page], :order=>'click_count desc', :per_page => 6
    else
      @products = @category.products.paginate :page=>params[:page], :order=>'price', :per_page => 6
    end

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
