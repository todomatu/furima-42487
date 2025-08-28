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
    binding.pry
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)
    # すでに保存されているユーザーのemailとpasswordを入力する
  end
  it 'ログイン失敗時、再びサインインページに移動する' do
  end
end
