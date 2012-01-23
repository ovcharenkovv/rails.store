class ProductSweeper < ActionController::Caching::Sweeper
  observe Product

  def after_create(product)
    expire_cache_for(product)
  end

  def after_update(product)
    expire_cache_for(product)
  end

  def after_destroy(product)
    expire_cache_for(product)
  end

  private

  def expire_cache_for(product)
    expire_fragment("product_#{product.category.id}_#{product.id}")

    if previous_product = Product.previous_product(product.id,product.category_id)
      expire_fragment("product_#{previous_product.category.id}_#{previous_product.id}")
    end

    if next_product = Product.next_product(product.id,product.category_id)
      expire_fragment("product_#{next_product.category.id}_#{next_product.id}")
    end

    expire_fragment("category#{product.category.id}_author#{}_page#{}_sort#{}")
    expire_fragment("category#{}_author#{product.author.id}_page#{}_sort#{}")
    expire_fragment(:controller => "products", :action => "index")
    expire_fragment('home_products')
    expire_fragment('top_products')
    expire_fragment('new_products')
    expire_fragment('rnd_products')
  end


end

