class ProductsController < ApplicationController

  before_filter :get_category_or_author , :init_params
  # GET /products
  # GET /products.xml

  def init_params
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = 24
    end

    if params[:sort]=='popularity'
      @sort = 'click_count desc'
    elsif params[:sort]=='price'
      @sort = 'price'
    else
      @sort = 'created_at desc'
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
    if params[:category_id]
      @products = Product.includes(:author).includes(:category).where(:category_id => @categories,:published => true).search(params[:q]).paginate :page=>params[:page], :order=>@sort, :per_page => @per_page
    elsif params[:author_id]
      @products = Product.includes(:author).includes(:category).where(:author_id => @categories , :published => true).search(params[:q]).paginate :page=>params[:page], :order=>@sort, :per_page => @per_page
    end


    #@products = Product.search(params[:q],params[:category_id],@categories,@sort,params[:page],@per_page)

    #if params[:category_id]
    #  @products = Product.includes(:author).includes(:category).where(:category_id => @categories,:published => true).paginate :page=>params[:page], :order=>@sort, :per_page => @per_page
    #elsif params[:author_id]
    #  @products = Product.includes(:author).includes(:category).where(:author_id => @categories , :published => true).paginate :page=>params[:page], :order=>@sort, :per_page => @per_page
    #end
  end

# GET /products/1
# GET /products/1.xml
  def show
    session[:product_category_id]=params[:category_id]

    @product = @category.products.find(params[:id])
    @comment = @product.comments.build
    @product.comments.pop

    if @product.published?
      @product.inc_click

      respond_to do |format|
        format.html # show.html.haml
        format.xml  { render :xml => @product }
      end
    else
       redirect_to root_path
    end
  end

  def new
    @product = @category.products.new
    authorize! :create, @product

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @product }
    end
  end

  def create
    @product = @category.products.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to category_products_path }
      else
        format.html { render :action => "new" }
      end
    end
  end


end
