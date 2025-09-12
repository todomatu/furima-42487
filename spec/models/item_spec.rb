require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  context '出品できる場合' do
    it 'item_name item_info item_category_id item_sales_status_id item_shipping_fee_status_id item_prefecture_id item_price user_id item_image があれば登録できる' do
      expect(@item).to be_valid
    end
  end
  context '出品できない場合' do
    it 'item_nameがからでは登録できない' do
      @item.item_name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item name can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_infoがからでは登録できない' do
      @item.item_info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item info can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_category_idがからでは登録できない' do
      @item.item_category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item category can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_sales_status_idがからでは登録できない' do
      @item.item_sales_status_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item sales status can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_shipping_fee_status_idがからでは登録できない' do
      @item.item_shipping_fee_status_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item shipping fee status can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_prefecture_idがからでは登録できない' do
      @item.item_prefecture_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item prefecture can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_priceがからでは登録できない' do
      @item.item_price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item price can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_imageがからでは、登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_category_igが1では登録できない' do
      @item.item_category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Item category can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_sales_status_idが1では登録できない' do
      @item.item_sales_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Item sales status can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_shipping_fee_status_idがでは登録できない' do
      @item.item_shipping_fee_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Item shipping fee status can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
    it 'item_prefecture_idが1では登録できない' do
      @item.item_prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Item prefecture can't be blank"
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end

    it 'item_priceが300~9,999,999以外では登録できない' do
      [1..299, 10_000_000..100_000_000].each do |range|
        num = Faker::Number.within(range: range)
        @item.item_price = num
        @item.valid?
        expect(@item.errors.full_messages).to include 'Item price must be an integer between 300 and 9,999,999'
        expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
      end
    end
    it 'userと紐づいていなければ登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include 'User must exist'
      expect(@item.errors.full_messages.size).to eq @item.errors.full_messages.uniq.size
    end
  end
end
