class Admin::ProductsController < Admin::AdminController
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
    @products = @category.products.paginate :page=>params[:page], :per_page => 50

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = @category.products.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = @category.products.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = @category.products.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = @category.products.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to admin_category_products_path }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = @category.products.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to admin_category_products_path}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = @category.products.find(params[:id])
    @product.destroy

    respond_to do |format|
      flash[:notice] = 'Product was successfully deleted.'
      format.html { redirect_to admin_category_products_path }
      format.xml  { head :ok }
    end
  end
end
