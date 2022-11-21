class Contact < ApplicationRecord
  enum category: {inappropriate_post_end_user:0, consultation_problems:1, others:2} 
  enum status: {outstanding:0, processing:1, closed:2}
  belongs_to :end_user
  
  validates :body, presence: true
end
