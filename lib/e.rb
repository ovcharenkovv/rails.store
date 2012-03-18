# -*- encoding : utf-8 -*-

require 'net/http'
require 'uri'
require 'iconv'
post_id='56231000143802'

uri = URI('http://91.220.203.10/site_services/tracking/tracking.php?lang=ua')
response = Net::HTTP.post_form(uri, 'en' => post_id, 'max' => '50')
result = Iconv.conv("UTF8", "CP1251", response.body.to_s)


puts result