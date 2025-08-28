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
    it 'birth_dateが未来の数値では登録できない' do
      @user.birth_date = Faker::Date.forward
      @user.valid?
      expect(@user.errors.full_messages).to include 'Birth date cannot be a future date'
    end
  end
end
