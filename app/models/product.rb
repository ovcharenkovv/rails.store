require 'paperclip_processors/watermark'
class Product < ActiveRecord::Base
  PRODUCT_STATUS = ["Есть в наличии","Под заказ" ]
  belongs_to :category
  belongs_to :author

  has_many :line_items
  has_many :orders, :through => :line_items
#  has_attached_file :image,
#                    :styles => { :small=> "125x94#", :thumb => "200x150#",:medium => "400x300#", :large => "800X600" },
#                    :convert_options => { :small =>"-quality 50",:thumb =>"-quality 65",:medium=>"-quality 85" }

  has_attached_file :image,
                    :styles => {
                        :small=>{
                            :geometry       => "125x94#",
                            :quality        => "40"
                        },
                        :thumb =>{
                            :geometry       => "200x150#",
                            :quality        => "50",
                        },
                        :medium =>{
                            :processors     => [:watermark],
                            :geometry       => "400x300#",
                            :quality        => "85",
                            :watermark_path => Rails.root.join('public/images/watermark_medium.png'),
                            :position       => "SouthEast"
                        },
                        :large=>{
                            :processors     => [:watermark],
                            :geometry       => "800X600#",
                            :watermark_path => Rails.root.join('public/images/watermark_large.png'),
                            :position       => "SouthEast"

                        }
                    }



  acts_as_commentable

  before_destroy :ensure_not_referenced_by_any_line_item
  before_create :generate_price

  validates :title,       :presence => true,
            :uniqueness => true,
            :length => {:minimum => 3, :maximum => 25}

  validates :category_id, :author_id, :presence => true

  def self.search(q)
    if q
      where('products.title LIKE :q OR products.id = :q  ',{:q => "#{q}%"})
    else
      scoped
    end
  end


  #def self.search(q,in_category,categories,sort,page,per_page)
  #  if q
  #    includes(:author).includes(:category).where('products.title LIKE :q OR products.id = :q  ',{:q => "#{q}%"},:published => true).paginate :page=>page, :order=>sort, :per_page => per_page
  #  else
  #    if in_category
  #      includes(:author).includes(:category).where(:category_id => categories,:published => true).paginate :page=>page, :order=>sort, :per_page => per_page
  #    else
  #      includes(:author).includes(:category).where(:author_id => categories,:published => true).paginate :page=>page, :order=>sort, :per_page => per_page
  #    end
  #  end
  #end

  def inc_click
    if self.click_count
      self.update_attribute(:click_count, self.click_count += 1)
    else
      self.update_attribute(:click_count, 1)
    end
  end

  def self.find_top_products(quantity)
#    find(:all,:limit => quantity, :order => 'click_count desc')
    includes(:author).includes(:category).where(:published => true).order("click_count desc").limit(quantity)
  end

  def self.find_new_products(quantity)
    includes(:author).includes(:category).where(:published => true).order("created_at desc").limit(quantity)
#    find(:all,:limit => quantity, :order => 'created_at desc')
  end

  def self.find_random_products (quantity,except)
    includes(:author).includes(:category).where(:published => true).where(["id NOT IN (?)", except]).order("RAND()").limit(quantity)
  end

  def self.find_hot_products(quantity)
    includes(:author).includes(:category).where(:published => true).where(["is_hot == (?)", '1']).limit(quantity).order("created_at desc")
  end

  def self.find_see_also_products(quantity,category,except)
#    where( :category_id=>category ).where(["id NOT IN (?)", except]).limit(quantity).order("click_count desc")
    includes(:author).includes(:category).where( :category_id=>category,:published => true ).where(["id NOT IN (?)", except]).limit(quantity).order("RAND()")
  end

  def generate_price
    if self.author_price < 45
      self.price =  self.author_price+15
    else
      self.price =  self.author_price+(self.author_price*0.35)
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
