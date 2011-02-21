class AuthorsController < ApplicationController
  # GET /authors
  # GET /authors.xml
  # add_breadcrumb "Мастера", :authors_path

  def index
    @authors = Author.all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @authors }
    end
  end

  # GET /authors/1
  # GET /authors/1.xml
  def show
    @author = Author.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @author }
    end
  end
end
