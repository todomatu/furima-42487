require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    # driven_by(:rack_test)
    @file = {
      'nickname' => :nickname,
      'email' => :email,
      'password' => :password,
      'password-confirmation' => :password_confirmation,
      'last-name' => :last_name,
      'first-name' => :first_name,
      'last-name-kana' => :last_name_kana,
      'first-name-kana' => :first_name_kana
    }
  end

  def set_birth(user)
    birth_year  = user.birth_date.year
    birth_month = user.birth_date.month
    birth_day   = user.birth_date.day

    select birth_year.to_s,  from: 'user_birth_date_1i'
    select birth_month.to_s, from: 'user_birth_date_2i'
    select birth_day.to_s,   from: 'user_birth_date_3i'
  end

  it '新規登録に成功し、トップページに遷移する' do
    # 予め、ユーザーを作る
    @user = FactoryBot.build(:user)
    # 新規登録ページに移動する
    visit new_user_registration_path
    page.driver.browser.manage.window.move_to(200, 100)
    page.driver.browser.manage.window.resize_to(1200, 800)

    # 新規登録ページに遷移していることを確認する
    expect(page).to have_current_path(new_user_registration_path)

    # すでに保存されているユーザーのemailとpasswordを入力する
    @file.each do |file_name, value|
      fill_in file_name, with: @user.send(value)
    end
    set_birth(@user)

    click_on '会員登録'
    sleep 1

    # トップページに遷移していることを確認する
    expect(page).to have_current_path(root_path)
  end
  it '新規登録に失敗し、再び新規登録ページにもどる' do
    # 予め、ユーザーを作る
    @user = FactoryBot.build(:user)
    @user.nickname = ''
    # 新規登録ページに移動する
    visit new_user_registration_path
    page.driver.browser.manage.window.move_to(200, 100)
    page.driver.browser.manage.window.resize_to(1200, 800)

    # 新規登録ページに遷移していることを確認する
    expect(page).to have_current_path(new_user_registration_path)

    # すでに保存されているユーザーのemailとpasswordを入力する
    @file.each do |file_name, value|
      fill_in file_name, with: @user.send(value)
    end
    set_birth(@user)

    click_on '会員登録'
    sleep 1

    # 新規登録ページに戻っていることを確認する
    expect(page).to have_current_path(new_user_registration_path)
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページに移動する
    visit new_user_session_path

    # サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_on 'ログイン'
    sleep 1

    # トップページに遷移していることを確認する
    expect(page).to have_current_path(root_path)
  end
  it 'ログイン失敗時、再びサインインページに移動する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # トップページに遷移する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)
    # 誤ったユーザー情報を入力する
    fill_in 'email', with: @user.email
    fill_in 'password', with: (@user.password + '$')
    # ログインボタンをクリックする
    click_on 'ログイン'
    # サインインページに戻ってきていることを確認する
    expect(page).to have_current_path(new_user_session_path)
  end
end
