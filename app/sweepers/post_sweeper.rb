# -*- encoding : utf-8 -*-
class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    expire_cache_for(post)
  end

  def after_update(post)
    expire_cache_for(post)
  end

  def after_destroy(post)
    expire_cache_for(post)
  end

  private

  def expire_cache_for(post)
    expire_fragment("shot_post_id_#{post.id.to_s}")
  end

end

