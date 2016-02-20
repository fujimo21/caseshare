class Like < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :suitcase, class_name: "Suitcase"
end
