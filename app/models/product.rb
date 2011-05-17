class Product < ActiveRecord::Base
  PRODUCT_STATUS = ["Есть в наличии","Под заказ" ]
  belongs_to :category
  belongs_to :author

  has_many :line_items
  has_many :orders, :through => :line_items
  has_many :comments
  has_attached_file :image, :styles => { :small=> "125x94", :thumb => "200x150>",:medium => "400x300>", :large => "500X375" }

#  before_destroy :ensure_not_referenced_by_any_line_item
  before_create :generate_price

  validates :title,       :presence => true,
            :uniqueness => true,
            :length => {:minimum => 3, :maximum => 25}

#  validates :price,       :presence => true,
#            :numericality => {:greater_than_or_equal_to => 0.01}

  validates :category_id, :author_id, :presence => true

  def inc_click
    if self.click_count
      self.update_attribute(:click_count, self.click_count += 1)
    else
      self.update_attribute(:click_count, 1)
    end
  end

  def self.find_top_products(quantity)
    find(:all,:limit => quantity, :order => 'click_count desc')
  end

  def self.find_new_products(quantity)
    find(:all,:limit => quantity, :order => 'created_at desc')
  end

  def self.find_random_products (quantity,except)
     where(["id NOT IN (?)", except]).order("RAND()").limit(quantity)
  end

  def self.find_hot_products(quantity)
    where(["is_hot == (?)", '1']).limit(quantity).order("created_at desc")
  end

  def self.find_see_also_products(quantity,category,except)
#    where( :category_id=>category ).where(["id NOT IN (?)", except]).limit(quantity).order("click_count desc")
    where( :category_id=>category ).where(["id NOT IN (?)", except]).limit(quantity).order("RAND()")
  end

  def generate_price
    if self.author_price < 34
      self.price =  self.author_price+10
    else
      self.price =  self.author_price+(self.author_price*0.3)
    end
  end

#  def self.find_see_also_random_products(quantity,category)
#    @see_also_products = where( :category_id=>category ).limit(quantity).order("click_count desc")
#
#    if @see_also_products.count > 3
#      @see_also_products
#    else
#      @category = Category.where(["parent_id != (?)", ''])
#      @category[rand(@category.count.to_i)]
#    end
#
#  end

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
