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
    it 'emailがからでは登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'passwordがからでは登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'first_nameがからでは登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it 'last_namがからでは登録できない' do
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
    it 'last_nameに半角文字が入ると登録できない' do
      @user.last_name += 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name must be full-width characters'
    end
    it 'first_nameに半角文字が入ると登録できない' do
      @user.first_name += 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name must be full-width characters'
    end
    it 'last_nameに空白が入ると登録できない' do
      @user.last_name += '　'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name must be full-width characters'
    end
    it 'first_nameに空白が入ると登録できない' do
      @user.first_name += '　'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name must be full-width characters'
    end
    it 'last_name_kanaに半角文字が入ると登録できない' do
      @user.last_name_kana += 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name kana must be katakana only'
    end
    it 'first_name_kanaに半角文字が入ると登録できない' do
      @user.first_name_kana += 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana must be katakana only'
    end
    it 'last_name_kanaに空白が入ると登録できない' do
      @user.last_name_kana += '　'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name kana must be katakana only'
    end
    it 'first_name_kanaに空白が入ると登録できない' do
      @user.first_name_kana += '　'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana must be katakana only'
    end
    it 'emailは@がなければ登録できない' do
      @user.email = @user.email.sub(/@/, '')
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end
    it '同一のemailがある場合登録できない' do
      @user.save
      user = FactoryBot.build(:user)
      user.email = @user.email
      user.valid?
      expect(user.errors.full_messages).to include 'Email has already been taken'
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
    it 'passwordが数字のみでは登録できない' do
      @user.password = Faker::Number.number(digits: rand(6..18)).to_s
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password must include both letters and numbers'
    end
    it 'passwordが英字のみでは登録できない' do
      @user.password = Faker::Alphanumeric.alpha(number: rand(6..18))
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password must include both letters and numbers'
    end
    it 'passwordに全角文字を含む場合は登録できない' do
      chars = (['ぁ'..'ん', 'ァ'..'ヶ', '一'..'龥'].map(&:to_a).flatten + %W[\u3005 \u30FC ヴ])
      num = rand(1..5)
      str = Array.new(num) { chars.sample }.join
      password = @user.password
      str.length.times do |time|
        l = password.length
        r = rand(l + 1)
        password.insert(r, str[time])
      end
      @user.password = password
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password cannot contain full-width characters'
    end
    it 'passwordとpassword_confirmationが同一でなければ登録できない' do
      @user.password = @user.password + 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'birth_dateが未来の数値では登録できない' do
      @user.birth_date = Faker::Date.forward
      @user.valid?
      expect(@user.errors.full_messages).to include 'Birth date cannot be a future date'
    end
  end
end
