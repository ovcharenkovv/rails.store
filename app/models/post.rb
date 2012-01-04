class Post < ActiveRecord::Base
  belongs_to :post_category
  validates :title, :presence => true,
            :uniqueness => true
  acts_as_commentable

#  before_create :create_slug

  def to_param
    slug
  end

  def create_slug
    self.slug = self.title.parameterize
  end

end
