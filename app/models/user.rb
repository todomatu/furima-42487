class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, presence: true
  validate :birth_cannot_be_in_the_future
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龠々ー]+\z/, message: 'must be full-width characters' }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶヴー]+\z/, message: 'must be katakana only' }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'must include both letters and numbers' }

  private

  def birth_cannot_be_in_the_future
    return unless birth_date.present? && birth_date > Date.today

    errors.add(:birth_date, 'cannot be a future date')
  end
end
