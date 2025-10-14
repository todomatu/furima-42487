require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end
  context '保存できる場合' do
    it 'orderと紐づいていれば登録できる' do
      expect(@address).to be_valid
    end
  end
  context '保存できない場合' do
    it 'orderと紐づいていない場合登録できない' do
      @address.order = nil
      @address.valid?
      expect(@address.errors.full_messages).to include('Order must exist')
    end
  end
end
