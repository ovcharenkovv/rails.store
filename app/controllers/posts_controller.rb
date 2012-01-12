require 'will_paginate/array'
class PostsController < ApplicationController
  before_filter :get_category

  def get_category
    @post_category = PostCategory.find_by_slug!(params[:post_category_slug])
  end

  # GET /posts
  # GET /posts.xml
  def index
    if params[:post_category_slug] =='content'
      redirect_to root_url
      return
    end
    @posts = @post_category.posts.find(:all ,:order=>'created_at desc').paginate :page=>params[:page], :per_page => '3'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = @post_category.posts.find_by_slug!(params[:post_slug])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

end
