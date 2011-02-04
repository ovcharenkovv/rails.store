class OrdersController < ApplicationController
  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to root_url, :notice => "Your cart is empty"
      return
    end
    @order = Order.new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @order }
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        Notifier.order_received(@order).deliver
        format.html { redirect_to(root_url, :notice => 'Thank you for your order.') }
        format.xml { render :xml => @order, :status => :created,
                            :location => @order }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @order.errors,
                            :status => :unprocessable_entity }
      end
    end
  end
end
