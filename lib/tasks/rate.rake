task :rate => :environment do
  authors = Author.all
  authors.each do |author|
    author.update_product_count
  end

  authors.each do |author|
    author.update_rate
  end


end