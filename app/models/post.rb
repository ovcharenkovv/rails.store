class Post < ActiveRecord::Base
  belongs_to :post_category
  validates :title, :presence => true,
            :uniqueness => true
  acts_as_commentable

  before_create :create_slug
  before_update :create_slug

  def to_param
    slug
  end

  def create_slug
    self.slug = self.title.parameterize
  end

#  def create_short_body
#    self.short_body = self.body[0..400]
#  end
end
