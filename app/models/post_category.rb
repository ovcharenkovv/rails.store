# -*- encoding : utf-8 -*-
class PostCategory < ActiveRecord::Base
  has_many :posts
  validates :name, :presence => true,
            :uniqueness => true
  before_create :create_slug

  def to_param
    slug
  end

  def create_slug
    self.slug = self.name.parameterize
  end
end
