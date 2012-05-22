# -*- encoding : utf-8 -*-
class CartsController < ApplicationController
  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, :notice => 'Invalid cart'
    else
      if @cart.line_items.count == 0
        redirect_to root_path, :notice => 'Invalid cart'
      else
        respond_to do |format|
          format.html # show.html.haml
          format.xml { render :xml => @cart }
        end
      end
    end
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @cart }
    end
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to(@cart, :notice => 'Cart was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml

  def destroy
    current_cart.line_items.destroy_all
    current_cart.destroy
    session[:cart_id] = nil
    session[:referer] = nil
    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.xml { head :ok }
    end
  end


end
