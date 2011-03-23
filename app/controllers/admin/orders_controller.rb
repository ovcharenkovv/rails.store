class Admin::OrdersController < Admin::AdminController
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.paginate :page=>params[:page],
                             :order=>'created_at desc',
                             :per_page => 30

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

end
