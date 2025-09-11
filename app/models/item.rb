class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :item_category_id
    validates :item_sales_status_id
    validates :item_prefecture_id
    validates :item_shipping_fee_status_id
    validates :item_scheduled_delivery_id
  end

  validates :item_price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'must be an integer between 300 and 9,999,999' }
  validates :item_name, :item_info, :item_price, :image, presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_sales_status
  belongs_to :item_prefecture
  belongs_to :item_shipping_fee_status
  belongs_to :item_scheduled_delivery
end
