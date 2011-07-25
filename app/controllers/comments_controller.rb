class CommentsController < ApplicationController

  def create
    @post_category = PostCategory.find_by_slug!(params[:post_category_id])
    @commentable = Comment.find_commentable(params[:commentable_type], params[:commentable_id])
    if @commentable
      @comment = @commentable.comments.build(params[:comment])
      if @comment.save
        flash[:notice] = "Спасибо за коментарий"
        redirect_to :controller => @commentable.class.name.underscore.downcase.pluralize, :action => 'show', :id => @commentable.slug, :anchor => 'comment_form'
#        redirect_to @commentable, :anchor => "comment_list", :notice => "Спасибо за коментарий"
      else
        flash.now[:notice] = "Заполните пожалуйста правельно все поля"  # edited 10/28/10 use 'flash.now' instead of 'flash'
        render_error_page
      end
    else
      redirect_to root_url, :alert => "Вы не можите оставить свой коментарий"
    end
  end

  private

  def render_error_page
    model_name = @commentable.class.name
    instance_variable_set("@#{model_name.downcase}", @commentable)
#    logger.info "!!!!!!!!!!!!!!!!!!!!!!"
#    logger.info "#{model_name.underscore.downcase.pluralize}/show"
    render "#{model_name.underscore.downcase.pluralize}/show"
  end

end
