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
| mail               | string | null: false, unique: true |
| last-name          | string | null: false |
| first-name         | string | null: false |
| birth-date         | date   | null: false |

### Association

- has_many :orders
- has_many :Listings
- has_many :order_items, through: :order , source: :item
- has_many :listing_items, through: :listing , source: :item

## order テーブル

| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## listing テーブル

| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## item テーブル

| Column                   | Type       | Options     |
| ------------------------ | ---------- | ----------- |
| item-name                | string     | null: false |
| item-info                | text       | null: false |
| category                 | references | null: false , foreign_key: true |
| item-sales-status        | text       | null: false |
| item-shipping-fee-status | string     | null: false |
| item-prefecture          | string     | null: false |
| item-scheduled-delivery  | string     | null: false |
| item-price               | integer    | null: false |

### Association

- belongs_to :order
- belongs_to :listing
- belongs_to :category
- has_one :order_user , through: :order, source: :user
- has_one :listing_user , through: :listing, source: :user

## category テーブル

| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| name    | string     |             |

### Association

- has_many :items