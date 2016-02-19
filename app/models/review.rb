class Review < ActiveRecord::Base
  belongs_to :suitcase
  belongs_to :user
end
