class Notifier < ActionMailer::Base
  default :from     => 'PoshStore <no-reply@poshstore.com.ua>',
          :cc       => 'lavrovanna@yandex.ru',
          :bcc      => 'ovcharenkovv@gmail.com',
          :reply_to => 'poshstoreua@gmail.com'

  def order_received(order)
    @order = order
    mail :to => @order.email, :subject => 'Заказ на Posh Store'
  end
  #def order_send(order)
  #  @order = order
  #  mail :to => 'lavrovanna@yandex.ru', :subject => 'Заказ на Posh Store'
  #end
  def order_shipped(order)
    @order = order
    mail :to => order.email, :subject => 'Заказ на Posh Store'
  end
  def product_admin_send(product,action)
    @product = product
    mail :to => 'lavrovanna@yandex.ru', :subject => action =='create' ? 'Добавлен новый товар' : 'Отредактирован товар'
  end
  def order_status_change(order)
    @order = order
    mail :to => @order.email, :subject => 'Статус Вашего заказа'
  end

end
