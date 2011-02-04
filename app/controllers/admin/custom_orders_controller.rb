class Admin::CustomOrdersController < Admin::AdminController
  # GET /admin/custom_orders
  # GET /admin/custom_orders.xml
  def index
    @admin_custom_orders = Admin::CustomOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_custom_orders }
    end
  end

  # GET /admin/custom_orders/1
  # GET /admin/custom_orders/1.xml
  def show
    @admin_custom_order = Admin::CustomOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_custom_order }
    end
  end

  # GET /admin/custom_orders/new
  # GET /admin/custom_orders/new.xml
  def new
    @admin_custom_order = Admin::CustomOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_custom_order }
    end
  end

  # GET /admin/custom_orders/1/edit
  def edit
    @admin_custom_order = Admin::CustomOrder.find(params[:id])
  end

  # POST /admin/custom_orders
  # POST /admin/custom_orders.xml
  def create
    @admin_custom_order = Admin::CustomOrder.new(params[:admin_custom_order])

    respond_to do |format|
      if @admin_custom_order.save
        format.html { redirect_to(@admin_custom_order, :notice => 'Custom order was successfully created.') }
        format.xml  { render :xml => @admin_custom_order, :status => :created, :location => @admin_custom_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_custom_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/custom_orders/1
  # PUT /admin/custom_orders/1.xml
  def update
    @admin_custom_order = Admin::CustomOrder.find(params[:id])

    respond_to do |format|
      if @admin_custom_order.update_attributes(params[:admin_custom_order])
        format.html { redirect_to(@admin_custom_order, :notice => 'Custom order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_custom_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/custom_orders/1
  # DELETE /admin/custom_orders/1.xml
  def destroy
    @admin_custom_order = Admin::CustomOrder.find(params[:id])
    @admin_custom_order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_custom_orders_url) }
      format.xml  { head :ok }
    end
  end
end
