require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  context '新規登録できる場合' do
    it 'email,password,nickname,last_name,first_name,last_name_kana,first_name_kana,birth_dateが存在すれば登録できる' do
      expect(@user).to be_valid
    end
  end
  context '新規登録できない場合' do
    it 'nicknameがからでは登録できない' do
      @user.nickname = ''
      @user.valid?

      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'passwordがからでは登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'passwordが５文字以下では登録できない' do
      @user.password = Faker::Internet.password(min_length: 5, max_length: 5)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end
    it 'passwordが１２９文字以上では登録できない' do
      @user.password = Faker::Internet.password(min_length: 129, max_length: 300)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too long (maximum is 128 characters)'
    end
    it 'passwordとpassword_confirmationが同一でなければ登録できない' do
      @user.password = @user.password + 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'emailがからでは登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'first_nameがからでは登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it 'last_nameがからでは登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it 'first_name_kanaがからでは登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end
    it 'last_name_kanaがからでは登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end
    it 'birth_dateがからでは登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end
    it 'birth_dateが未来の数値では登録できない' do
      @user.birth_date = Faker::Date.forward
      @user.valid?
      expect(@user.errors.full_messages).to include 'Birth date cannot be a future date'
    end
  end
end
