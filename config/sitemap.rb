# -*- encoding : utf-8 -*-
# Set the host name for URL creation

SitemapGenerator::Sitemap.default_host = "http://poshstore.com.ua/"

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  # 
  # 
  # Examples:
  # 
  # Add '/articles'
  #   
  #   sitemap.add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add individual articles:
  #
  #   Article.find_each do |article|
  #     sitemap.add article_path(article), :lastmod => article.updated_at
  #   end
  #Add '/categories'
  #sitemap.add categories_path, :priority => 0.7, :changefreq => 'daily'

  Category.find_each do |category|
    sitemap.add category_path(category), :lastmod => category.updated_at , :priority => 0.9
  end

#  Product.find_each do |product|
  Product.where(:published => true ).each do |product| 
    sitemap.add category_product_path(product.category_id,product),
                :lastmod => product.updated_at ,
                :priority => 0.5 ,
                :changefreq => 'daily'
  end

  Post.where(:post_category_id => 2).each do |post|
    sitemap.add short_post_path('master-class',post),
                :lastmod => post.updated_at ,
                :priority => 0.5 ,
                :changefreq => 'daily'
  end


end
