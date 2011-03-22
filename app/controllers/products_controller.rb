class ProductsController < ApplicationController

  before_filter :get_category_or_author , :init_params
  # GET /products
  # GET /products.xml

  def init_params
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = 12
    end

    if params[:sort]=='popularity'
      @sort = 'click_count desc'
    else
      @sort = 'price'
    end
  end

  def init_breadcrumb
    if params[:category_id]
      #add_breadcrumb "Категории", :categories_path
      #add_breadcrumb "Изделия", :category_products_path
    end
    if params[:author_id]
      #add_breadcrumb "Мастера", :authors_path
      #add_breadcrumb "Изделия", :author_products_path
    end
  end

  def get_category_or_author
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @categories = @category.children
      if @categories.count == 0
        @categories = @category
      end
    end
    if params[:author_id]
      @categories = Author.find(params[:author_id])
      @category = @categories
    end
  end

  def index
    session[:product_params]=params

    if params[:category_id]
      @products = Product.where(:category_id => @categories ).paginate :page=>params[:page], :order=>@sort, :per_page => @per_page
    elsif params[:author_id]
      @products = Product.where(:author_id => @categories ).paginate :page=>params[:page], :order=>@sort, :per_page => @per_page
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

    @see_also_products = Product.find_see_also_products(9,@category.id)

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @product }
    end
  end
end
