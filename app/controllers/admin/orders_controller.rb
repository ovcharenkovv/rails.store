class Admin::OrdersController < Admin::AdminController
  # GET /orders
  # GET /orders.xml
  def index
    if (params[:status] == 'all')||(params[:status].nil?)
      @orders = Order.paginate :page=>params[:page], :order=>'created_at desc',:per_page => 30
    else
      @orders = Order.where(:status=>params[:status]).paginate :page=>params[:page], :order=>'created_at desc',:per_page => 50
    end

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    @line_items = LineItem.where(:order_id=>params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @order }
    end
  end

  def edit
    @order = Order.find(params[:id])
    @line_items = LineItem.where(:order_id=>params[:id])
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
#        format.html { redirect_to admin_orders_path(:status=>'new')}
        format.html { redirect_to admin_order_path(@order)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

end
