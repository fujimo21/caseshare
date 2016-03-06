class Suitcase < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews
  has_many :likes, foreign_key: "suitcase_id"
  has_many :like_users, class_name: "User", through: :likes, source: :user, dependent: :destroy
  
  validates :case_type, presence: true
  validates :case_size, presence: true
  validates :price, presence: true
  validates :listing_name, presence: true, length: {maximum:50}
  validates :summary, presence: true, length: {maximum: 50}
  
  
  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
