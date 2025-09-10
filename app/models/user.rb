class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, presence: true
  validate :birth_cannot_be_in_the_future
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龠々ー]+\z/, message: 'must be full-width characters' }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶヴー]+\z/, message: 'must be katakana only' }
  validate :password_complexity

  has_many :items

  private

  def birth_cannot_be_in_the_future
    return unless birth_date.present? && birth_date > Date.today

    errors.add(:birth_date, 'cannot be a future date')
  end

  def password_complexity
    return if password.blank?

    errors.add(:password, 'cannot contain full-width characters') unless password =~ /\A[\x00-\x7F]+\z/
    return if password =~ /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

    errors.add(:password, 'must include both letters and numbers')
  end
end
