class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

  validates :name,     :presence => true,
                       :length => {:minimum => 3, :maximum => 254}

  validates :address,  :presence => true,
                       :length => {:minimum => 3, :maximum => 254}

  validates :email,    :presence => true,
                       :length => {:minimum => 3, :maximum => 254},
                       :uniqueness => true,
                       :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  validates :pay_type, :presence => true,
                       :inclusion => PAYMENT_TYPES

  has_many :line_items,:dependent => :destroy



  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
