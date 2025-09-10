require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  context '出品できる場合' do
    it 'item_name item_info item_category_id item_sales_status_id item_shipping_fee_status_id item_prefecture_id item_price user_id があれば登録できる' do
      expect(@item).to be_valid
    end
  end
  context '出品できない場合' do
    %w[item_name item_info item_category_id item_sales_status_id item_shipping_fee_status_id item_prefecture_id
       item_price].each do |attr|
      it "#{attr}がからでは登録できない" do
        @item.send("#{attr}=", '')
        @item.valid?
        expect(@item.errors.full_messages).to include "#{attr.humanize} can't be blank"
      end
    end
    %w[item_category_id item_sales_status_id item_shipping_fee_status_id item_prefecture_id].each do |attr|
      it "#{attr}が1では登録できない" do
        @item.send("#{attr}=", 1)
        @item.valid?
        expect(@item.errors.full_messages).to include "#{attr.humanize} can't be blank"
      end
    end
    it 'item_priceが300~9,999,999以外では登録できない' do
      [1..299, 10_000_000..100_000_000].each do |range|
        num = Faker::Number.within(range: range)
        @item.item_price = num
        @item.valid?
        expect(@item.errors.full_messages).to include 'Item price must be between 300 and 9,999,999'
      end
    end
    it 'userと紐づいていなければ登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include 'User must exist'
    end
  end
end
