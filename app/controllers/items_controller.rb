class ItemsController < ApplicationController
  # indexアクション設定
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  # createアクションにデータ保存のための記述
    # 保存されたときはルートパスに戻る(redirect_to)
    # 保存されなかったときは新規投稿ページへ戻る(render)
  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  

  private

  # privateメソッドにストロングパラメーターをセットし、特定の値のみを受け付けるように記述。
  # user_idもmerge
  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info,
      :category_id,
      :sales_status_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price
    ).merge(user_id: current_user.id)
  end

end
