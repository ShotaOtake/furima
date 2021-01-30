class OrdersController < ApplicationController

  # pay_form.rbからのインスタンス変数@orderを生成
  def index 
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end

  def create
    binding.pry
    @order = PayForm.new(order_params)
    if @order.valid?
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
