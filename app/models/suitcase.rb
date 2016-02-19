class Suitcase < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews
  
  validates :case_type, presence: true
  validates :case_size, presence: true
  validates :summary, presence: true, length: {maximum: 50}

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
