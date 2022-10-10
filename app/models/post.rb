class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations, dependent: :destroy
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, {presence: true, length: {maximum:100}}

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

end
