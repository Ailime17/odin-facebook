class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :sent_friend_requests, foreign_key: 'sender_id', class_name: 'FriendRequest', dependent: :destroy
  has_many :received_friend_requests, foreign_key: 'receiver_id', class_name: 'FriendRequest', dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy

  validates :phone_number, uniqueness: true, unless: -> { phone_number.blank? }

  def friends
    friends = []
    sent_friend_requests.accepted.includes(:receiver).each do |request|
      friends << request.receiver
    end
    received_friend_requests.accepted.includes(:sender).each do |request|
      friends << request.sender
    end
    friends
  end

  # def friends_with?(user)
  #   sent_friend_requests.where(receiver: user).or(received_friend_requests.where(sender: user)).accepted.exists?
  # end

  def sent_friend_request_to?(user)
    sent_friend_requests.where(receiver: user).pending.exists?
  end

  def received_friend_request_from?(user)
    received_friend_requests.where(sender: user).pending.exists?
  end

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
