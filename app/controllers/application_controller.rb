class ApplicationController < ActionController::Base
  include BreadcrumbsOnRails::ControllerMixin

  protect_from_forgery
  before_filter :get_root_category, :get_authors , :get_current_cart
  layout "application"

  add_breadcrumb "Home", :root_path


  def get_root_category
    @root_categories = Category.all
  end

  def get_authors
    @root_authors = Author.all
  end
  def get_current_cart
    @current_cart = current_cart
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end


end