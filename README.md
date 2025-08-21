# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計
## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association

- has_many :orders
- has_many :items
- has_many :ordered_items, through: :orders , source: :item

## orders テーブル

| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル
| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| postal_code   | string     | null: false |
| select_box_id | integer    | null: false |
| city          | text       | null: false |
| addresses     | text       | null: false |
| building      | text       |             |
| phone_number  | string     | null: false |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order


## items テーブル

| Column                      | Type       | Options     |
| --------------------------- | ---------- | ----------- |
| item_name                   | string     | null: false |
| item_info                   | text       | null: false |
| item_category_id            | integer    | null: false |
| item_sales_status_id        | integer    | null: false |
| item_shipping_fee_status_id | integer    | null: false |
| item_prefecture_id          | integer    | null: false |
| item_scheduled_delivery_id  | integer    | null: false |
| item_price                  | integer    | null: false |
| user                        | references | null: false , foreign_key: true |

### Association

- belongs_to :user
- has_one :order