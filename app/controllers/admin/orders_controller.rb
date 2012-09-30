# -*- encoding : utf-8 -*-
class Admin::OrdersController < Admin::AdminController
  require 'PostBoxStatus'

  def index
    @orders = Order.search(params)

    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @orders }
    end
  end

  def show
    @order = Order.find(params[:id])
    @line_items = LineItem.where(:order_id => params[:id])

    #if @order.shipment_id
    #  @post_box_status = PostBoxStatus.info @order.shipment_id, @order.delivery_type
    #else
    #  @post_box_status = "please add shipment id"
    #end


    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @order }
    end
  end

  def edit
    @order = Order.find(params[:id])
    @line_items = LineItem.where(:order_id => params[:id])
  end

  def update
    @order = Order.find(params[:id])

    prev_order_status= @order.status
    current_order_status = params[:order][:status]

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        Notifier.order_status_change(@order).deliver if current_order_status != prev_order_status && current_order_status != 'new'

        if current_order_status==Order::ORDER_STATUS[4]
          Order.update_sales_counts(@order)
        end


        format.html { redirect_to admin_order_path(@order) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_orders_url) }
      format.xml { head :ok }
    end
  end

  def postbox
    @order = Order.find(params[:id])


    if @order.shipment_id
      @post_box_status = PostBoxStatus.info @order.shipment_id, @order.delivery_type
    else
      @post_box_status = "please add shipment id"
    end

    respond_to do |format|
      format.xml { render :xml => @post_box_status }
      format.html { render :json => @post_box_status }
    end

  end

end
