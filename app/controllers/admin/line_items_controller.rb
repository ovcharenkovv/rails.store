# -*- encoding : utf-8 -*-
class Admin::LineItemsController < Admin::AdminController

  def destroy
    @line_item = LineItem.find(params[:id])
    @order = Order.find(@line_item.order_id)
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to(admin_order_path(@order)) }
    end
  end

  def inc
    @line_item = LineItem.find(params[:id])

    @line_item.inc
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def dec
    @line_item = LineItem.find(params[:id])
    @line_item.dec

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end
