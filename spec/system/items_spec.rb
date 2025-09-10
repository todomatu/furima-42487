require 'rails_helper'

RSpec.describe 'Items', type: :system do
  before do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @item = FactoryBot.build(:item)
  end

  def set(item)
    image_path = Rails.root.join('public/images/test_image.png')
    attach_file('item-image', image_path, make_visible: true)

    fill_in 'item-name', with: item.item_name
    fill_in 'item-info', with: item.item_info
    fill_in 'item-price', with: item.item_price

    file_id = {
      'item-category' => [Category, item.item_category_id],
      'item-sales-status' => [ItemSalesStatus, item.item_sales_status_id],
      'item-shipping-fee-status' => [ItemShippingFeeStatus, item.item_shipping_fee_status_id],
      'item-prefecture' => [ItemPrefecture, item.item_prefecture_id],
      'item-scheduled-delivery' => [ItemScheduledDelivery, item.item_scheduled_delivery_id]
    }

    file_id.each do |n, i|
      next if i[1].nil?

      status = i[0].find(i[1])
      select status.name, from: n
    end
  end
  context '出品に成功する場合' do
    it '商品出品に成功しルートページに戻る' do
      # ユーザーをログインする
      visit root_path
      # 出品ページに移動する
      click_link '出品する'
      sleep 1

      # 出品ページに移動しているか確認する
      expect(page).to have_current_path(new_item_path)

      # アイテム情報を入力する
      set(@item)

      # ボタンを押す
      expect do
        find('[name="commit"]').click
        sleep 1
      end.to change { Item.count }.by(1)
    end
  end
  context '出品に失敗する場合' do
    it 'ログインしていない場合、出品ページにアクセスしようとするとログインページに飛ばされる' do
      logout(:user)
      # ルートパスに訪れる
      visit root_path
      # リンクをクリックする
      click_link '出品する'
      sleep 1

      # ログインページに移動しているか確認する
      expect(page).to have_current_path(new_user_session_path)
    end
    it '入力情報が足りない場合、ページが再表示される' do
      # 出品ページにアクセスする
      visit new_item_path
      # 出品ページに移動しているか確認する
      expect(page).to have_current_path(new_item_path)

      # アイテム情報を入力する
      @item.item_name = ''
      set(@item)
      # 出品ページが表示されているか確認する
      expect do
        find('[name="commit"]').click
        sleep 1
      end.to change { Item.count }.by(0)
      expect(page).to have_content("can't be blank")
      expect(page).to have_content('商品の情報を入力')
      expect(page).to have_content(@item.item_info)
    end
  end
end
