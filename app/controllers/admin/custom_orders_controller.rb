class Admin::CustomOrdersController < Admin::AdminController
  # GET /admin/custom_orders
  # GET /admin/custom_orders.xml
  def index
    @admin_custom_orders = Admin::CustomOrder.all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @admin_custom_orders }
    end
  end

  # GET /admin/custom_orders/1
  # GET /admin/custom_orders/1.xml
  def show
    @admin_custom_order = Admin::CustomOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @admin_custom_order }
    end
  end
end
