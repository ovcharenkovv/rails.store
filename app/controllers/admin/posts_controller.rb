# -*- encoding : utf-8 -*-
class Admin::PostsController < Admin::AdminController
  before_filter :get_category

  def get_category
    @post_category = PostCategory.find_by_slug!(params[:post_category_id])
  end

  # GET /posts
  # GET /posts.xml
  def index
    @posts = @post_category.posts.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = @post_category.posts.find_by_slug!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = @post_category.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = @post_category.posts.find_by_slug!(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = @post_category.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(admin_post_category_posts_url(@post_category), :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = @post_category.posts.find_by_slug!(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(admin_post_category_posts_url(@post_category), :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = @post_category.posts.find_by_slug!(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(admin_post_category_posts_url(@post_category)) }
      format.xml  { head :ok }
    end
  end
end
