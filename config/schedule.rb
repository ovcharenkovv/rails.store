# -*- encoding : utf-8 -*-
every 12.hours, :at => 30 do
  rake "-s sitemap:refresh"
end
