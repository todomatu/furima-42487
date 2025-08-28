require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    # driven_by(:rack_test)
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページに移動する
    visit new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
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
