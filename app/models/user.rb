class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :phone_number, uniqueness: true, unless: -> { phone_number.blank? }

  attr_writer :login


  def login
    @login || phone_number || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['phone_number = ? OR email = ?', login.to_i, login.to_s.downcase]).first
    elsif conditions.has_key?(:phone_number) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
