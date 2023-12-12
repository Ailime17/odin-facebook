class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture do |a|
    a.variant :standard, resize_to_limit: [150, 150]
  end

  validates :first_name, :surname, :birthday, :gender, presence: true
end
