require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '内容に問題ない場合' do
    it 'itemとuserがあれば保存ができること' do
      expect(@order).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'userと紐づいていなくては登録できない' do
      @order.user = nil
      puts @order.errors.full_messages
    end
    it 'itemと紐づいていなくては登録できない' do
      @order.item = nil
      puts @order.errors.full_messages
    end
  end
end
