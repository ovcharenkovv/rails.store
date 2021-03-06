# -*- encoding : utf-8 -*-
class Admin::DashboardController < Admin::AdminController
  require 'BundleProductsPicture'
  def index
    card_number = Parameter.find_by_key('card-number')
    if (card_number && card_number.value.to_s.length > 0 )
      @card_number = card_number.value
    end
  end

  def get_picture
    from = params[:from].to_datetime.to_formatted_s(:db) unless params[:from].blank?
    to = params[:to].to_datetime.to_formatted_s(:db) unless params[:to].blank?
    if !from.nil? && !to.nil?
      products = Product.between_date_created(from,to)
      bundle = BundleProductsPicture.do products, "/var/www/poshstore/shared/public/system/images/"
      if !bundle.nil?
        send_file bundle.path, :type => 'application/zip', :disposition => 'attachment', :filename => "pictures.zip"
        bundle.close
      end
    else
      redirect_to admin_path
    end
  end
end
