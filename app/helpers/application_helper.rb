# -*- encoding : utf-8 -*-

module ApplicationHelper
  def meta_title(param)
    ret=""

    if param[:controller]=='home'
      ret += 'PoshStore - интернет магазин изделий ручной работы, бижутериии, авторских работ, хенд мейд, хендмейд, handmade.'
    end

    if param[:controller]=='products' && param[:action]=='show'
      if param[:id] && !param[:cart_id]
        ret += Product.find(param[:id]).title.to_s
        ret += ' '
        ret += ' Купить в интернет магазине. '
      end
    end
    if param[:category_id] && param[:action]!='show'
      ret += ' Купить '
      ret += Category.find(param[:category_id]).name.mb_chars.downcase.to_s
      ret += ' в интернет магазине.'
    end
    if param[:author_id]
      ret += 'Работы мастера '
      ret += Author.find(param[:author_id]).name.to_s
    end

    if param[:post_slug]
      ret += Post.find_by_slug!(params[:post_slug]).title.to_s
      ret += ' '
    end

    if param[:post_category_slug]
      ret += PostCategory.find_by_slug!(params[:post_category_slug]).name.to_s
      ret += ' '
    end


    ret
  end

  def meta_keywords(param)
    ret=""

    if param[:controller]=='home' || param[:author_id]
      ret += 'купить, купить в интернет магазине, интернет-магазин, украшения, изделия, ручная работа, бижутерия, hand made, handmade, хенд мейд, аксессуары, полимерная, декупаж'
    end

    if param[:controller]=='products' && param[:action]=='show'
      if param[:id] && !param[:cart_id]
        ret += 'купить '
        ret += Product.find(param[:id]).title.to_s
        ret += ', '
        ret += 'продажа '
        ret += Product.find(param[:id]).title.to_s
        ret += ', '
        ret += 'интернет магазин, доставка '
      end
    end

    if param[:category_id]
      ret += 'купить '
      ret += Category.find(param[:category_id]).name
      ret += ', '
      ret += 'продажа '
      ret += Category.find(param[:category_id]).name
      ret += ', '
      ret += 'интернет магазин, доставка '
    end

    if param[:post_slug]
      ret += Post.find_by_slug!(params[:post_slug]).title
      ret += ', '
    end

    if param[:post_category_slug]
      ret += PostCategory.find_by_slug!(params[:post_category_slug]).name
      ret += ', '
    end

    ret
  end

  def meta_description(param)
    ret=""
    if param[:post_slug]
      ret += 'Здесь вы найдете мастер-классы по изготовлению '
      ret += Post.find_by_slug!(params[:post_slug]).title
    else
      if param[:controller]=='home'
        ret += 'PoshStore - интернет магазин украшений ручной работы.'
      end

      if param[:category_id] && param[:action]!='show'
        ret += 'Здесь можно купить '
        ret += Category.find(param[:category_id]).name
        ret += ', хендмейд, handmade, украшения, и многое другое'
      end
      if param[:author_id]
        ret += 'Работы мастера '
        ret += Author.find(param[:author_id]).name
      end

      if param[:controller]=='products' && param[:action]=='show'
        if param[:id] && !param[:cart_id]
          product = Product.find(param[:id])
          if product.description.length > 100
            ret += strip_tags(Product.find(param[:id]).description.to_s)[0..250]
          else
            ret += Product.find(param[:id]).title.to_s
            ret +=' Покупки с удовольствием. Категория: '
            ret += Category.find(param[:category_id]).name.to_s
          end
        end
      end

    end

    ret

  end
end
