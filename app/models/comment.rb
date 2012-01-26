# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true


  validates :user_name,:presence => true,
                       :length => {:minimum => 3, :maximum => 254}

  validates :comment,  :presence => true,
                       :length => {:minimum => 2, :maximum => 1500}

  validates :user_email,:presence => true,
                       :length => {:minimum => 3, :maximum => 254},
                       :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  # belongs_to :user

  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  def self.comments_count (commentable_id)
    where(:published=>true).where(:commentable_id=>commentable_id).count
  end

  def publish_self
    self.published  = true
  end
  def self.publish_parent(parent_id)
    if parent_id
      parent = find(parent_id)
      parent.publish_self
      parent.save
    end
  end
  def self.child_id(r_email)
     where(:user_email=>r_email).last
  end


end
