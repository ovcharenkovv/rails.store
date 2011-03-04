class Notifier < ActionMailer::Base
  default :from => "poshstoreua@gmail.com"



  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #

  def order_received(order)
    @order = order
    mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation'
  end
  def order_send1(order)
    @order = order
    mail :to => 'ovcharenkovv@gmail.com', :subject => 'Pragmatic Store Order Confirmation'
  end
  def order_send2(order)
    @order = order
    mail :to => 'lavrovanna@yandex.ru', :subject => 'Pragmatic Store Order Confirmation'
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #

  def order_shipped(order)
    @order = order
    mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end


end
