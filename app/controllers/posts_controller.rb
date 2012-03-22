# -*- encoding : utf-8 -*-
require 'will_paginate/array'
class PostsController < ApplicationController
  before_filter :get_category

  def get_category
    @post_category = PostCategory.find_by_slug!(params[:post_category_slug])
  end
  def index
    if params[:post_category_slug] =='content'
      redirect_to root_url
      return
    end
    @posts = @post_category.posts.where(:published=>true).find(:all ,:order=>'created_at desc').paginate :page=>params[:page], :per_page => '5'
    fresh_when(:etag => [@posts,@current_cart,@current_cart.line_items])
  end
  def show
    @post = @post_category.posts.where(:published=>true).find_by_slug!(params[:post_slug])
    fresh_when(:etag => [@post,@current_cart,@current_cart.line_items])
  end
end
