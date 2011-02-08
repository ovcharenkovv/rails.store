class Product < ActiveRecord::Base

  belongs_to :category
  belongs_to :author

  has_many :line_items
  has_many :orders, :through => :line_items
  has_attached_file :image, :styles => { :thumb => "170x170>",:medium => "300x300>", :large => "500X500" }

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title,       :presence => true,
            :uniqueness => true,
            :length => {:minimum => 3, :maximum => 25}

  validates :description, :presence => true,
            :length => {:minimum => 3, :maximum => 254}

  validates :price,       :presence => true,
            :numericality => {:greater_than_or_equal_to => 0.01}

  validates :category_id, :author_id, :presence => true

  def inc_click
    if self.click_count
      self.update_attribute(:click_count, self.click_count += 1)
    else
      self.update_attribute(:click_count, 1)
    end
  end

  def self.find_top_products(quantity)
    find(:all,:limit => quantity)
  end
  
  def self.find_hot_products(quantity)
    where(["is_hot == (?)", '1']).limit(quantity)
  end


  #def self.find_products_for_sale(page,per_page)
  #  find(:all, :order => "title" ).paginate :page=>page, :per_page => per_page
  #end

  #def self.find_products_by_category(category_id,page)
  #  where(["category_id == (?)", category_id]).all.paginate :page=>page, :order=>'created_at desc', :per_page => 3
  #end


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
end
