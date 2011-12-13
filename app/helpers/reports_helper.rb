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

  def calc_wages_report orders
    @orders_count              = 0
    @products_count            = 0
    @products_price_sum        = 0
    @products_author_price_sum = 0
    @products_spent_sum        = 0
    @wages                     = 0

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
    @wages = @products_price_sum-@products_author_price_sum-@products_spent_sum
  end

  def puts_wages_report orders
    calc_wages_report orders
    raw"<h3 class='red'>продано товаров    : #{@products_count}</h3>
        <h3 class='red'>успешных проддаж   : #{@orders_count}</h3>
        <h3 class='red'>выручка от продаж  : #{@products_price_sum}</h3>
        <h3 class='red'>оплата мастерам    : #{@products_author_price_sum}</h3>
        <h3 class='red'>росходы курєру     : #{@products_spent_sum}</h3>
        <h1 class='red'>общий доход        : #{@wages}</h1>"
  end

  def calc_wages_for_period from,to
    orders = Order.wages(from,to)
    calc_wages_report orders
    @wages
  end

  def wages_array from, to
    from_beginning_date = from.at_beginning_of_month
    to_beginning_date = to.at_beginning_of_month
    to_end_date = from.at_end_of_month
    @wages_array = Hash.new
    while from_beginning_date != to_beginning_date
      @wages_array[from_beginning_date.month] = calc_wages_for_period(from_beginning_date.to_formatted_s(:db) ,to_end_date.to_formatted_s(:db))
      from_beginning_date = from_beginning_date.next_month
      to_end_date = to_end_date.next_month.at_end_of_month
    end
    @wages_array = @wages_array.sort
    @wages_array
  end

  def chart_data_table from, to
    wages_array(from, to)
    header = "data.addColumn('string', 'Month'); data.addColumn('number', 'Wages'); data.addColumn('number', 'Expenses'); data.addRows(#{@wages_array.count});"
    @chart_data_table = ""
    @x = 0
    @wages_array.each do |key,value|
      @chart_data_table+=" data.setValue(#{@x}, 0, '#{Date::MONTHNAMES[key]}');"
      @chart_data_table+=" data.setValue(#{@x}, 1, #{value});"
      @chart_data_table+=" data.setValue(#{@x}, 2, #{Expense.for_month(key).sum(&:amount)});"
      #@chart_data_table+=" data.setValue(#{@x}, 3, #{value-Expense.for_month(key).sum(&:amount)});"
      @x += 1
    end
    @chart_data_table = header + @chart_data_table
    @chart_data_table
  end

end
