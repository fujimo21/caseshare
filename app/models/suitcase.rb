class Suitcase < ActiveRecord::Base
  belongs_to :user
  
  validates :case_type, presence: true
  validates :case_size, presence: true
  validates :summary, presence: true, length: {maximum: 50}

end
