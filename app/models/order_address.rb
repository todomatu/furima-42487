class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :item_prefecture_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validate :item_is_not_order
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Please include hyphen(-)' }
    validates :item_prefecture_id,
              numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 48,
                              message: 'must be selected' }
    validates :city
    validates :address, format: { with: /[0-9０-９一二三四五六七八九〇壱弐参肆伍陸漆捌玖拾ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹ]/,
                                  message: 'must include number' }
    validates :phone_number,
              format: { with: /\A\d{10,11}\z/,
                        message: 'Phone number must follow the format: area code + number + number.' }
  end
  def save
    order = Order.new(item_id: item_id, user_id: user_id)
    return unless order.save

    Address.create(postal_code: postal_code, item_prefecture_id: item_prefecture_id, city: city, address: address, building: building,
                   phone_number: phone_number, order_id: order.id)
  end

  def item_is_not_order
    return unless Order.exists?(item_id: item_id)

    errors.add(:item_id, 'has already been purchased')
  end
end
