class ItemsController < ApplicationController
# 処理が呼ばれた段階で、ユーザーがログインしていなければ、そのユーザーをログイン画面に遷移させる
before_action :authenticate_user!, only: [:new, :create, :edit, :update]
# コントローラで定義されたアクションが実行される前に、共通の処理を行う
before_action :set_item, only:[ :show, :edit, :update ]
# @itemと紐づくユーザーが一致していない場合はトップページへ
before_action :move_to_index, only:[ :edit, :update ]

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

  # showアクションにインスタンス変数@itemを定義
  # 且つ、Pathパラメータで送信されるID値で、Itemモデルの特定のオブジェクトを取得するように記述し、それを@itemに代入
  def show
    # @item = Item.find(params[:id])
  end

  # editアクションにインスタンス変数@itemを定義
  # Pathパラメータで送信されるID値で、Itemモデルの特定のオブジェクトを取得するように記述し、それを@itemに代入
  def edit
    # @item = Item.find(params[:id])
  end

  # データを更新する記述をし、更新されたときはそのitemの詳細ページに戻るような記述をした
  # データが更新されなかったときは、編集ページに戻るようにrenderを用いて記述
  def update
    # @item = Item.find(params[:id])
    if @item.valid?
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  # destroyアクションに、商品を削除し、トップページに戻るような記述をした
  def destroy
    @item.destroy
    redirect_to root_path
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

  # @itemの定義
  def set_item
    @item = Item.find(params[:id])
  end

  # @itemと紐づくユーザーが一致していない場合はトップページへ
  def move_to_index
     return redirect_to root_path if current_user.id != @item.user.id
  end

end
