class Message < ApplicationRecord
  belongs_to :user
  has_many :spams
  has_one_attached :image

  validates_presence_of :caption
end
