# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController

  def create
    @commentable = Comment.find_commentable(params[:commentable_type], params[:commentable_id])
    if @commentable
      @comment = @commentable.comments.build(params[:comment])

      if user_signed_in?
        @comment.publish_self
        Comment.publish_parent(params[:comment][:parent_id])
#        if params[:comment][:parent_id]
#          @parent = Comment.find(params[:comment][:parent_id])
#          @parent.publish_self
#          @parent.save
#        end
      end
      if @comment.save
        Notifier.comment_admin1_send(@comment).deliver
        Notifier.comment_admin2_send(@comment).deliver
        Notifier.comment_user_send(@comment).deliver
        flash[:notice] = "Спасибо за комментарий! После модерации он появится на сайте!"
        redirect_to :controller => @commentable.class.name.underscore.downcase.pluralize, :action => 'show', :id => @commentable.id, :anchor => 'comment_form'
      else
        flash.now[:notice] = "Заполните пожалуйста все поля правильно"
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
