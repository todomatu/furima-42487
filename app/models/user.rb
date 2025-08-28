class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, presence: true
  validate :birth_cannot_be_in_the_future

  private

  def birth_cannot_be_in_the_future
    return unless birth_date.present? && birth_date > Date.today

    errors.add(:birth_date, 'cannot be a future date')
  end
end
