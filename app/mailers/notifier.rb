class Notifier < ActionMailer::Base
  default :from => "poshstoreua@gmail.com"



  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #

  def order_received(order)
    @order = order
    mail :to => @order.email, :subject => 'Заказ на Posh Store'
  end
  def order_send1(order)
    @order = order
    mail :to => 'ovcharenkovv@gmail.com', :subject => 'Заказ на Posh Store'
  end
  def order_send2(order)
    @order = order
    mail :to => 'lavrovanna@yandex.ru', :subject => 'Заказ на Posh Store'
  end
  def order_shipped(order)
    @order = order
    mail :to => order.email, :subject => 'Заказ на Posh Store'
  end
  def comment_admin1_send(comment)
    @comment = comment
    mail :to => 'ovcharenkovv@gmail.com', :subject => 'Коментарий на Posh Store'
  end
  def comment_admin2_send(comment)
    @comment = comment
    mail :to => 'lavrovanna@yandex.ru', :subject => 'Коментарий на Posh Store'
  end
  def comment_user_send (comment)
    @comment = comment
    mail :to => comment.user_email, :subject => 'Коментарий на Posh Store'
  end
  def product_admin1_send(product)
    @product = product
    mail :to => 'ovcharenkovv@gmail.com', :subject => 'Добавлен новый товар'
  end
  def product_admin2_send(product)
    @product = product
    mail :to => 'lavrovanna@yandex.ru', :subject => 'Добавлен новый товар'
  end

end
