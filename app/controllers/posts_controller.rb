class PostsController < ApplicationController
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
    @comment = @post.comments.build
    @post.comments.pop

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

end
