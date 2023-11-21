class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :first_name, :surname, :birthday, :gender, presence: true
end
