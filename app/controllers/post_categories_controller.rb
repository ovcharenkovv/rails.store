class PostCategoriesController < ApplicationController
  # GET /post_categories
  # GET /post_categories.xml
  def index
    @post_categories = PostCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @post_categories }
    end
  end

  # GET /post_categories/1
  # GET /post_categories/1.xml
  def show
    @post_category = PostCategory.find_by_slug!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post_category }
    end
  end
end
