require 'rails_helper'

RSpec.describe PayForm, type: :model do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order = FactoryBot.build(:pay_form, user_id: @user.id, item_id: @item.id)
    end
    describe '商品購入' do
        context '内容に問題ない場合' do
          it '全て正常' do
            expect(@order).to be_valid
          end

          it '建物名がなくても保存ができる' do
            @order.building = ''
            expect(@order).to be_valid
          end

        end
        context '内容に問題がある場合' do

          it 'postal_code:必須' do
            @order.postal_code = nil
            @order.valid?
            expect(@order.errors.full_messages).to include("Postal code can't be blank")
          end
          it 'postal_code:ハイフンがない' do
            @order.postal_code = '1234567'
            @order.valid?
            expect(@order.errors.full_messages).to include('Postal code is invalid')
          end
          it 'postal_code:文字が混じっている' do
            @order.postal_code = '123-abcd'
            @order.valid?
            expect(@order.errors.full_messages).to include('Postal code is invalid')
          end
          it 'prefecture:必須' do
            @order.prefecture_id = nil
            @order.valid?
            expect(@order.errors.full_messages).to include("Prefecture can't be blank")
          end
          it 'prefecture:0以外' do
            @order.prefecture_id = 0
            @order.valid?
            expect(@order.errors.full_messages).to include("Prefecture must be other than 0")
          end
          it 'city:必須' do
            @order.city = nil
            @order.valid?
            expect(@order.errors.full_messages).to include("City can't be blank")
          end
          it 'addresses:必須' do
            @order.address = ''
            @order.valid?
            expect(@order.errors.full_messages).to include("Address can't be blank")
          end
          it 'phone_number:必須' do
            @order.phone_number = ''
            @order.valid?
            expect(@order.errors.full_messages).to include("Phone number can't be blank")
          end
          it 'phone_number:12桁以上' do
            @order.phone_number = '012345678901'
            @order.valid?
            expect(@order.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
          end
          it 'phone_number:文字混じり' do
            @order.phone_number = '012345abcde'
            @order.valid?
            expect(@order.errors.full_messages).to include("Phone number is invalid")
          end
          it 'user_id:必須' do
            @order.user_id = nil
            @order.valid?
            expect(@order.errors.full_messages).to include("User can't be blank")
          end
          it 'item_id:必須' do
            @order.item_id = nil
            @order.valid?
            expect(@order.errors.full_messages).to include("Item can't be blank")
          end
          it 'token:必須' do
            @order.token = ''
            @order.valid?
            expect(@order.errors.full_messages).to include("Token can't be blank")
          end
        end
    end
end