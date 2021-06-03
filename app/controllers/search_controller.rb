class SearchController < ApplicationController
  def search
    # 入力した文字列を入れる
    @value = params["search"]["value"]
    # 選択したモデルを入れる
    @model = params["search"]["model"]
    # 選択した検索方法を入れる
    @how = params["search"]["how"]
    # すべての検索結果をインスタンス変数に入れる
    @datas = search_for(@how, @model, @value)  
  end

 private

  # howの調べ方１つずつについてストロングパラメーターを設定していく
  # 完全一致
  def match(model,value)
    if model == 'user'
      User.where(name: value)
    elsif model == 'book'
      Book.where(title: value)
    end
  end

#前方一致
  def forward(model, value)
    if model == 'User'
      # マークのつける位置で検索条件を変更しているvalueの周辺確認
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end


# 後方一致
  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
    
  end

#部分一致
  def partical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end