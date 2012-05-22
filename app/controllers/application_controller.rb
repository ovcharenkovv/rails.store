# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_current_cart, :save_referer
  layout "application"

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_url
  end

  def get_current_cart
    if !session[:cart_id].nil?
      @current_cart = current_cart
    end

  end

  def save_referer
    if !session[:referer].nil?
      session['referer'] = request.env["HTTP_REFERER"] || 'none'
    end
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
