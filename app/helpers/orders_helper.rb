# -*- encoding : utf-8 -*-
module OrdersHelper
  def priority_class order_date, status

    if status=='success'
      "green"
    else
      if DateTime.now.to_date.to_date >= order_date.to_date+4
        "urgent"
      elsif DateTime.now.to_date.to_date >= order_date.to_date+2
        "major"
      end
    end
  end
end
