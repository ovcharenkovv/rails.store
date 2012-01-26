# -*- encoding : utf-8 -*-
class AuthorSweeper < ActionController::Caching::Sweeper
  observe Author

  def after_create(author)
    expire_cache_for(author)
  end

  def after_update(author)
    expire_cache_for(author)
  end

  def after_destroy(author)
    expire_cache_for(author)
  end

  private

  def expire_cache_for(author)
    expire_fragment('sidebar')
  end


end

