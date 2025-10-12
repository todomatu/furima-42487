class Order < ApplicationRecord
  attr_accessor :token

  belongs_to :item
  belongs_to :user
  validates :token, presence: true
end
