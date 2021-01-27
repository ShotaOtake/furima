class OrdersController < ApplicationController

  # pay_form.rbからのインスタンス変数@orderを生成
  def index 
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end

end
