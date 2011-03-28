class CustomOrdersController < ApplicationController

  # GET /custom_orders/1
  # GET /custom_orders/1.xml
  def show
    @custom_order = CustomOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @custom_order }
    end
  end

  # GET /custom_orders/new
  # GET /custom_orders/new.xml
  def new
    @custom_order = CustomOrder.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @custom_order }
    end
  end

  # POST /custom_orders
  # POST /custom_orders.xml
  def create
    @custom_order = CustomOrder.new(params[:custom_order])

    respond_to do |format|
      if verify_recaptcha(:model => @custom_order, :message => "Oh! It's error with reCAPTCHA!") && @custom_order.save
        format.html { redirect_to(@custom_order, :notice => 'Custom order was successfully created.') }
        format.xml  { render :xml => @custom_order, :status => :created, :location => @custom_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @custom_order.errors, :status => :unprocessable_entity }
      end
    end
  end

end
