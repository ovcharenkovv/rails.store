class ArticlesController < ApplicationController
  def show
    @article = Article.find_by_slug(params[:slug])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @article }
    end
  end
end
