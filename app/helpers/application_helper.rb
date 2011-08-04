module ApplicationHelper
  def store_title(param)
    ret=""
    if param[:controller]=='products'
      if param[:id] && !param[:cart_id]
        ret += Product.find(param[:id]).title.to_s
        ret += ' - '
        ret += Product.find(param[:id]).price.to_s+' грн.'
        ret += ' | '
      end
    end
    if param[:category_id]
      ret += Category.find(param[:category_id]).name.to_s
      ret += ' | '
    end
    if param[:author_id]
      ret += Author.find(param[:author_id]).name.to_s
      ret += ' | '
    end

    if param[:author_id]
      ret += Author.find(param[:author_id]).name.to_s
      ret += ' | '
    end

    if param[:post_slug]
      ret += Post.find_by_slug!(params[:post_slug]).title.to_s
      ret += ' | '
    end

    if param[:post_category_slug]
      ret += PostCategory.find_by_slug!(params[:post_category_slug]).name.to_s
      ret += ' | '
    end

    ret += 'Магазин изделий ручной работы hand made'

    ret
  end
end
