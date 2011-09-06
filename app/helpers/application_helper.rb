module ApplicationHelper
  def meta_title(param)
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

    ret += 'PoshStore - магазин изделий ручной работы, handmade бижутериии, авторские работы.'

    ret
  end

  def meta_keywords(param)
    ret=""

    if param[:category_id]
      ret += Category.find(param[:category_id]).name
      ret += ', '
    end

    if param[:post_slug]
      ret += Post.find_by_slug!(params[:post_slug]).title
      ret += ', '
    end

    if param[:post_category_slug]
      ret += PostCategory.find_by_slug!(params[:post_category_slug]).name
      ret += ', '
    end

    if param[:controller]=='products'
      if param[:id] && !param[:cart_id]
        ret += Product.find(param[:id]).title
        ret += ', '
      end
    end
    ret += 'ручная работа, бижутерия, hand made, handmade, хенд мейд, купить, интернет-магазин, полимерная бижутерия, декупаж'

    ret
  end

  def meta_description(param)
    ret=""
    if param[:post_slug]
      ret += 'Здесь вы найдете изделия ручной работы и мастер-классы по изготовлению | '
      ret += Post.find_by_slug!(params[:post_slug]).title
    else
      ret += 'Здесь можно купить изделия ручной работы, '

      if param[:category_id]
        ret += Category.find(param[:category_id]).name
        ret += ', '
      end

      ret += 'хендмейд бижутерия, handmade украшения, открытки ручной работы, '

      if param[:controller]=='products'
        if param[:id] && !param[:cart_id]
          ret += Product.find(param[:id]).title.to_s
          ret += ', '
        end
      end

      ret += 'и массу других товаров.'

    end

    ret

  end
end
