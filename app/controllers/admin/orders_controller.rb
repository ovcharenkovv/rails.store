class Admin::OrdersController < Admin::AdminController
  require 'PostBoxStatus'

  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.search(params)

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

    if @order.shipment_id
      @post_box_status = PostBoxStatus.info @order.shipment_id, @order.delivery_type
    else
      @post_box_status = "please add shipment id"
    end


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

    prev_order_status= @order.status
    current_order_status = params[:order][:status]

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        Notifier.order_status_change(@order).deliver if current_order_status != prev_order_status  && current_order_status != 'new'
        format.html { redirect_to admin_order_path(@order)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

end
