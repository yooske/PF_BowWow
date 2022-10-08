class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations, dependent: :destroy
  belongs_to :end_user

  validates :title, presence: true
  validates :body, {presence: true, length: {maximum:100}}
end
