class Order < ActiveRecord::Base
  PAYMENT_TYPES = ["Перевод на карту Приватбанка","Наложеный платеж" ]
  DELIVERY_TYPES = ["Новая почта","Укрпочта","Автолюкс" ]
  ORDER_STATUS = ["new","paid","sent","success","refused","closed"]

  validates :name,     :presence => true
  validates :telephone,:presence => true

  #validates :email,    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}


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

end

