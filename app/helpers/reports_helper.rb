module ReportsHelper

  def puts_status_report orders
    raw"<h3 class='red'>новых            :  #{orders.where(:status=>'new').count}</h3>
        <h3 class='red'>успешных         :  #{orders.where(:status=>'success').count}</h3>
        <h3 class='red'>ожидают проплаты :  #{orders.where(:status=>'payment_waiting').count}</h3>
        <h3 class='red'>проплаченые      :  #{orders.where(:status=>'paid').count}</h3>
        <h3 class='red'>отправленые      :  #{orders.where(:status=>'sent').count}</h3>
        <h3 class='red'>передумали       :  #{orders.where(:status=>'refused').count}</h3>
        <h3 class='red'>закрытые         :  #{orders.where(:status=>'closed').count}</h3>"
  end
  def puts_spent_report orders
    raw "<h3 class='red'>Сумма курєру:  #{orders.sum(:spent)}</h3>"
  end

  def puts_wages_report orders
    @orders_count              = 0
    @products_count            = 0
    @products_price_sum        = 0
    @products_author_price_sum = 0
    @products_spent_sum        = 0

    orders.each do |order|
      order.line_items.each do |line_item|
        @products_count += 1
        @products_price_sum += line_item.product.price unless line_item.product.nil?
        @products_author_price_sum += line_item.product.author_price unless line_item.product.nil?
      end
      @orders_count += 1
      @products_price_sum += Order::DELIVERY_PRICE
      @products_spent_sum += order.spent.to_i
    end
    raw"<h3 class='red'>продано товаров    : #{@products_count}</h3>
        <h3 class='red'>успешных проддаж   : #{@orders_count}</h3>
        <h3 class='red'>выручка от продаж  : #{@products_price_sum}</h3>
        <h3 class='red'>оплата мастерам    : #{@products_author_price_sum}</h3>
        <h3 class='red'>росходы курєру     : #{@products_spent_sum}</h3>
        <h1 class='red'>общий доход        : #{@products_price_sum-@products_author_price_sum-@products_spent_sum}</h1>"
  end

end
