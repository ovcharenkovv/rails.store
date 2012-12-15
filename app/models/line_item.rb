# -*- encoding : utf-8 -*-
class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def inc
    self.update_attribute(:quantity, self.quantity += 1)
  end

  def dec
    self.update_attribute(:quantity, self.quantity -= 1)
  end

end
