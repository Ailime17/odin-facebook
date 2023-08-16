class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :sent_friend_requests, foreign_key: 'sender_id', class_name: 'FriendRequest'
  has_many :received_friend_requests, foreign_key: 'receiver_id', class_name: 'FriendRequest'

  validates :phone_number, uniqueness: true, unless: -> { phone_number.blank? }

  #logic to allow for sign-in via phone OR email
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
