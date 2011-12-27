require 'paperclip_processors/watermark'
class Product < ActiveRecord::Base
  PRODUCT_STATUS = ["Есть в наличии","Под заказ" ]
  belongs_to :category
  belongs_to :author

  has_many :line_items
  has_many :orders, :through => :line_items

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
  before_save :generate_price

  validates :title,       :presence => true,
            :uniqueness => true,
            :length => {:minimum => 3, :maximum => 25}
  validates :category_id, :author_id, :author_price, :presence => true
  validates_numericality_of :author_price, :greater_than_or_equal_to => 10, :less_than_or_equal_to => 300
  validates_attachment_presence :image

  def self.search(q)
    if q
      where('products.title LIKE :q OR products.id = :q  ',{:q => "#{q}%"})
    else
      scoped
    end
  end

  def inc_click
    if self.click_count
      self.update_attribute(:click_count, self.click_count += 1)
    else
      self.update_attribute(:click_count, 1)
    end
  end

  def self.find_top_products(quantity)
    #find(:all,:limit => quantity, :order => 'click_count desc')
    #includes(:author).includes(:category).where(:published => true).order("click_count desc").limit(quantity)
    #where('products.id = line_items.product_id and line_items.order_id is not null').group('count(products.id)').limit(quantity)
    find_by_sql("SELECT products.*
                FROM products, line_items
                WHERE products.id = line_items.product_id AND line_items.order_id is not null
                GROUP BY products.id
                ORDER BY count(product_id) desc
                LIMIT #{quantity};")
  end

  def self.find_new_products(quantity)
    includes(:author).includes(:category).where(:published => true).order("created_at desc").limit(quantity)
  end

  def self.find_random_products (quantity,except)
    includes(:author).includes(:category).where(:published => true).where(["id NOT IN (?)", except]).order("RAND()").limit(quantity)
  end

  def self.find_hot_products(quantity)
    includes(:author).includes(:category).where(:published => true).where(["is_hot == (?)", '1']).limit(quantity).order("created_at desc")
  end

  def self.find_see_also_products(quantity,category,except)
    includes(:author).includes(:category).where( :category_id=>category,:published => true ).where(["id NOT IN (?)", except]).limit(quantity).order("RAND()")
  end

  def self.between_date_created(from,to)
    where("created_at BETWEEN '#{from}' AND '#{to}'").where(:published=>true)
  end


  def generate_price
    if self.author_price < 45
      self.price =  self.author_price+15
    else
      self.price =  self.author_price+(self.author_price*0.35)
    end
  end

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
