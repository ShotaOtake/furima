class OrdersController < ApplicationController
  # 未ログイン者をログインページへ遷移
  before_action :authenticate_user!
  before_action :set_item
  # 出品者が購入できないようにするための処理
  before_action :move_to_index

  # pay_form.rbからのインスタンス変数@orderを生成
  def index 
    # @item = Item.find(params[:item_id])
    @order = PayForm.new
  end

  # Payjpクラスのapi_keyというインスタンスに秘密鍵を代入
  # Payjp::Charge.createというクラスおよびクラスメソッドを使用
  def create
    @order = PayForm.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      # @item = Item.find(params[:item_id])
      render :index
    end

  end

  private

  # tokenの情報が取得できるように編集
  def order_params
    params.require(:pay_form).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number
      ).merge(user_id: current_user.id,item_id: params[:item_id] , token: params[:token])
  end

  def pay_item 
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] #環境変数と合わせましょう
    Payjp::Charge.create(
      amount: @item.price, # 決済額
      card: order_params[:token], # カード情報
      currency: 'jpy' # 通貨単位
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  # すでに購入されたものは再度購入できないようにする
  def move_to_index
    return redirect_to root_path if current_user.id == @item.user.id || @item.order.present? # 追加
  end

end
