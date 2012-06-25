# -*- encoding : utf-8 -*-
require 'paperclip_processors/watermark'
class Product < ActiveRecord::Base

  PRODUCT_STATUS = ["Есть в наличии", "Под заказ"]
  belongs_to :category
  belongs_to :author

  has_many :line_items
  has_many :orders, :through => :line_items

  has_attached_file :image,
                    :styles => {
                        :small => {
                            :geometry => "125x94#",
                            :quality => "40"
                        },
                        :thumb => {
                            :geometry => "200x150#",
                            :quality => "50",
                        },
                        :medium => {
                            :processors => [:watermark],
                            :geometry => "400x300#",
                            :quality => "85",
                            :watermark_path => Rails.root.join('public/images/watermark_medium.png'),
                            :position => "SouthEast"
                        },
                        :large => {
                            :processors => [:watermark],
                            :geometry => "800X600#",
                            :watermark_path => Rails.root.join('public/images/watermark_large.png'),
                            :position => "SouthEast"

                        }
                    }

  acts_as_commentable

  before_destroy :ensure_not_referenced_by_any_line_item
  before_create :generate_price, :save_product_count
  before_save :generate_price, :save_product_count

  validates :title, :presence => true,
            :uniqueness => true,
            :length => {:minimum => 3, :maximum => 45}
  validates :category_id, :author_id, :author_price, :presence => true
  validates_numericality_of :author_price, :greater_than_or_equal_to => 10, :less_than_or_equal_to => 300
  validates_attachment_presence :image

  def self.search(params)
    if params[:search]
      where('title LIKE ?', "%#{params[:search]}%").where('published is true').paginate :page => params[:page], :order => 'created_at desc', :per_page => 60
    else
      nil
    end
  end


  def inc_click
    if self.click_count
      self.update_attribute(:click_count, self.click_count += 1)
    else
      self.update_attribute(:click_count, 1)
    end
  end

  def self.find_top_products(quantity, month_before)
    find_by_sql("SELECT products.*
                FROM products, line_items
                WHERE products.id = line_items.product_id AND line_items.order_id is not null AND products.published = true
                AND  products.created_at BETWEEN DATE_SUB(now(), INTERVAL #{month_before} MONTH) AND now()
                GROUP BY products.id
                ORDER BY count(product_id) desc
                LIMIT #{quantity};")
  end

  def self.find_new_products(quantity)
    includes(:author).includes(:category).where(:published => true).order("created_at desc").limit(quantity)
  end

  def self.find_random_products (quantity, except)
    includes(:author).includes(:category).where(:published => true).where(["id NOT IN (?)", except]).order("RAND()").limit(quantity)
  end

  def self.find_hot_products(quantity)
    includes(:author).includes(:category).where(:published => true).where(["is_hot == (?)", '1']).limit(quantity).order("created_at desc")
  end

  def self.find_see_also_products(quantity, category, except)
    includes(:author).includes(:category).where(:category_id => category, :published => true).where(["id NOT IN (?)", except]).limit(quantity).order("RAND()")
  end

  def self.between_date_created(from, to)
    where("created_at BETWEEN '#{from}' AND '#{to}'").where(:published => true)
  end


  def generate_price
    if self.author_price < 45
      self.price = self.author_price+self.category.min_margin
    else
      self.price = self.author_price+(self.author_price*(self.category.margin.to_f/100))
    end
  end

  def self.author_products_count author_id
    where(:author_id => author_id, :published => true).count
  end

  def self.author_sales_count author_id

    #includes(:line_items).where(:author_id => author_id, :published => true).where("line_items.order_id IS NOT NULL").count(:author_id)
    find_by_sql("SELECT count(products.author_id)
                 FROM products, line_items
                 WHERE products.id = line_items.product_id AND line_items.order_id IS NOT NULL AND products.published = TRUE AND products.author_id =  #{author_id};")
  end

  def save_product_count
    self.author.update_product_count
  end

  def self.next_product id, category_id
    where(:published => true).where(:category_id => category_id).where("id < #{id}").last
  end

  def self.previous_product id, category_id
    where(:published => true).where(:category_id => category_id).where("id > #{id}").first
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
