class Product < ActiveRecord::Base

  belongs_to :category
  belongs_to :author

  has_many :line_items
  has_many :orders, :through => :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description,:category_id, :author_id, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  

  default_scope :order => 'title'

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  def self.find_products_for_sale(page)
    find(:all, :order => "title" ).paginate :page=>page, :order=>'created_at desc', :per_page => 3
  end

  def self.find_products_by_category(category_id,page)
    where(["category_id == (?)", category_id]).all.paginate :page=>page, :order=>'created_at desc', :per_page => 3


  end

  def self.find_products_by_author(author_id,page)
    where(["author_id == ?", author_id]).all.paginate :page=>page, :order=>'created_at desc', :per_page => 3
  end


end  
