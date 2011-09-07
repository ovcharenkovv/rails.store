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
    expire_fragment('home_products')
    expire_fragment('top_products')
    expire_fragment('new_products')
    expire_fragment('rnd_products')
  end


end

