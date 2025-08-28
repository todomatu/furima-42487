require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  context '新規登録できる場合' do
    it 'email,password,nickname,last_name,first_name,last_name_kana,first_name_kana,birth_dateが存在すれば登録できる' do
    end
  end
  context '新規登録できない場合' do
    it 'nicknameがからでは登録できない' do
    end
    it 'passwordがからでは登録できない' do
    end
    it 'passwordが５文字以下では登録できない' do
    end
    it 'passwordが１２９文字以上では登録できない' do
    end
    it 'emailがからでは登録できない' do
    end
    it 'first_nameがからでは登録できない' do
    end
    it 'last_nameがからでは登録できない' do
    end
    it 'first_name_kanaがからでは登録できない' do
    end
    it 'last_name_kanaがからでは登録できない' do
    end
    it 'birth_dateがからでは登録できない' do
    end
    it 'birth_dataが未来の数値では登録できない' do
    end
  end
end
