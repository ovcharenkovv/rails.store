# -*- encoding : utf-8 -*-
module PostBoxStatus
  def PostBoxStatus.info post_id, post_type
    require 'net/http'
    require 'uri'
    require 'iconv'
    begin
      if post_type == 'Укрпочта - 23 грн.'

        page = Hpricot(Net::HTTP.get(URI.parse("http://80.91.187.254:8080/servlet/SMCSearch2?lang=ua&barcode=#{post_id}".strip)))
        response = page.search("//center//div//div") if !page.nil?
        result = String.new
        for i in 1..2
          result+="<p style='color:red;'>#{response[i].inner_html}</p>" if !response[i].nil?
        end
      end

      if post_type == 'Новая почта - 23 грн.'
        uri = URI('http://91.220.203.10/site_services/tracking/tracking.php?lang=ua')
        response = Net::HTTP.post_form(uri, 'en' => post_id, 'max' => '50')
        result = Iconv.conv("UTF8", "CP1251", response.body.to_s)
      end
    rescue Exception => result
    end
    result
  end
end

