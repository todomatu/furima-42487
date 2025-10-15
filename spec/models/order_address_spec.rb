require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before(:all) do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
  end
  after(:all) do
    Item.delete_all
    User.delete_all
  end
  before do
    @order_address = FactoryBot.build(:order_address, item_id: @item.id, user_id: @user.id)
  end
  context '保存できる場合' do
    it ':item_id, :user_id, :postal_code, :item_prefecture_id, :city, :address, :building, :phone_number, :tokenがあれば登録できる' do
      expect(@order_address).to be_valid
    end
    it 'buildingがなくても登録できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end
  context '保存できない場合' do
    it 'tokenが空では登録できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it 'item_idがからでは登録できない' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
    it 'item_idが重複している場合登録できない' do
      n = FactoryBot.create(:order).item
      @order_address.item_id = n
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Item has already been purchased')
    end
    it 'user_idがからでは登録できない' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end
    it 'postal_codeがからでは登録できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが形式に合っていないと登録できない' do
      @order_address.postal_code = '1111111'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Please include hyphen(-)')
    end
    it 'postal_codeが全角数字の場合は保存できない' do
      @order_address.postal_code = @order_address.postal_code.tr('0-9', '０-９')
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Please include hyphen(-)')
    end
    it 'item_prefecture_idがからでは登録できない' do
      @order_address.item_prefecture_id = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Item prefecture must be selected')
    end
    it 'cityがからでは登録できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it 'addressがからでは登録できない' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end
    it 'addressが形式にあっていなくては登録できない' do
      @order_address.address = @order_address.address.gsub(/\d/, '')
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Address must include number')
    end
    it 'phone_numberがからでは登録できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが数字でない時では登録できない' do
      @order_address.phone_number = 'a'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number number must be entered without hyphens, 10 or 11 digits')
    end
    it 'phone_numberにハイフンが入っている時登録できない' do
      @order_address.phone_number = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number number must be entered without hyphens, 10 or 11 digits')
    end
    it '電話番号が9桁だと登録できない' do
      @order_address.phone_number = Faker::Number.number(digits: 9)
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number number must be entered without hyphens, 10 or 11 digits')
    end
    it '電話番号が12桁だと登録できない' do
      @order_address.phone_number = Faker::Number.number(digits: 12)
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number number must be entered without hyphens, 10 or 11 digits')
    end
  end
end
