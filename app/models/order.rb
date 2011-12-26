class Order < ActiveRecord::Base
  PAYMENT_TYPES = ["Перевод на карту Приватбанка","Наложеный платеж" ]
  DELIVERY_TYPES = ["Новая почта - 20 грн.","Укрпочта - 20 грн.","Автолюкс - 20 грн." ]
  DELIVERY_PRICE = 20
#  DELIVERY_TYPES_PRICE = [["Укрпочта", "15"], ["Новая почта", "20"] , ["Автолюкс", "20"]]
  ORDER_STATUS = ["new", "payment_waiting" , "paid","sent","success","refused","closed"]

  validates :name,     :presence => true
  validates :telephone,:presence => true

  validates :email,    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
            :presence => true


#  validates :address,  :presence => true,
#                       :length => {:minimum => 3, :maximum => 254}


#  validates :pay_type, :presence => true,
#                       :inclusion => PAYMENT_TYPES

  has_many :line_items,:dependent => :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def self.by_status(from,to)
    where("created_at BETWEEN '#{from}' AND '#{to}'").order(:status)
  end

  def self.by_spent(from,to)
    where("created_at BETWEEN '#{from}' AND '#{to}'").where('spent >=0')
  end

  def self.wages(from,to)
    where("created_at BETWEEN '#{from}' AND '#{to}'").where(:status=>'success')
  end

  def self.search(params)
    if params[:search]
      where('id LIKE ? OR name LIKE ? OR telephone LIKE ? OR address LIKE ? OR shipment_id LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").paginate :page=>params[:page], :order=>'created_at desc',:per_page => 100
    elsif (params[:status] == 'all')||(params[:status].nil?)
      paginate :page=>params[:page], :order=>'created_at desc',:per_page => 100
    else
      where(:status=>params[:status]).paginate :page=>params[:page], :order=>'created_at desc',:per_page => 100
    end
  end

  def self.order_sum order
    order.line_items.to_a.sum { |item| item.total_price }
  end

end

