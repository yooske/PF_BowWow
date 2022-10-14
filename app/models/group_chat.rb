class GroupChat < ApplicationRecord
  belongs_to :group
  belongs_to :end_user

  validates :message, presence: true, length: {maximum: 140}
end
