class Group < ApplicationRecord
  belongs_to :owner, class_name: 'EndUser'
  has_many :group_users
  has_many :end_users, through: :group_users, source: :end_user, dependent: :destroy

  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-img.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def is_owned_by?(end_user)
    owner.id == end_user.id
  end

  def includesEndUser?(end_user)
    group_users.exists?(end_user_id: end_user.id)
  end

  validates :name, uniqueness: true, presence: true
  validates :introduction, presence: true
end
