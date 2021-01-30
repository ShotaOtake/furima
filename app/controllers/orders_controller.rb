class OrdersController < ApplicationController

  # pay_form.rbからのインスタンス変数@orderを生成
  def index 
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end

  # Payjpクラスのapi_keyというインスタンスに秘密鍵を代入
  # Payjp::Charge.createというクラスおよびクラスメソッドを使用
  def create
    @order = PayForm.new(order_params)
    if @order.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY'] #環境変数と合わせましょう
      Payjp::Charge.create(
      amount: @item.price, # 決済額
      card: order_params[:token], # カード情報
      currency: 'jpy' # 通貨単位
    )
      @order.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
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

end
