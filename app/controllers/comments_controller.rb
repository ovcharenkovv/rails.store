class CommentsController < ApplicationController

  def create
    @commentable = Comment.find_commentable(params[:commentable_type], params[:commentable_id])
    if @commentable
      @comment = @commentable.comments.build(params[:comment])
      if @comment.save
        flash[:notice] = "Спасибо за коментарий"
        redirect_to :controller => @commentable.class.name.underscore.downcase.pluralize, :action => 'show', :id => @commentable.id, :anchor => 'comment_form'
      else
        flash.now[:notice] = "Заполните пожалуйста все поля правильно"  # edited 10/28/10 use 'flash.now' instead of 'flash'
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
    render "#{model_name.underscore.downcase.pluralize}/show"
  end

end
