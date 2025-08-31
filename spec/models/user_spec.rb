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
    %w[nickname email password first_name last_name first_name_kana last_name_kana birth_date].each do |attr|
      it "#{attr}がからでは登録できない" do
        @user.send("#{attr}=", '')
        @user.valid?
        expect(@user.errors.full_messages).to include "#{attr.humanize} can't be blank"
      end
    end
    %w[last_name first_name].each do |attr|
      it "#{attr}に半角文字が入ると登録できない" do
        @user.send("#{attr}=", @user.send(attr) + 'a')
        @user.valid?
        expect(@user.errors.full_messages).to include "#{attr.humanize} must be full-width characters"
      end
      it "#{attr}に空白が入ると登録できない" do
        @user.send("#{attr}=", @user.send(attr) + '　')
        @user.valid?
        expect(@user.errors.full_messages).to include "#{attr.humanize} must be full-width characters"
      end
    end
    %w[last_name_kana first_name_kana].each do |attr|
      it "#{attr}に半角文字が入ると登録できない" do
        @user.send("#{attr}=", @user.send(attr) + 'a')
        @user.valid?
        expect(@user.errors.full_messages).to include "#{attr.humanize} must be katakana only"
      end
      it "#{attr}に空白が入ると登録できない" do
        @user.send("#{attr}=", @user.send(attr) + '　')
        @user.valid?
        expect(@user.errors.full_messages).to include "#{attr.humanize} must be katakana only"
      end
    end
    it 'emailは@がなければ登録できない' do
      @user.email.sub!(/@/, '')
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
      @user.password = Faker::Number.number(digits: rand(6..18))
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
