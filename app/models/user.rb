class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable

  validates :fullname, presence: true, length: {maximum: 50}
  
  has_many :suitcases
  has_many :reservations
  has_many :reviews
  has_many :likes
  has_many :likes, foreign_key: "user_id"
  has_many :like_suitcases, class_name: "Suitcase", through: :likes, source: :suitcase, dependent: :destroy

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.fullname = auth.info.name
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.image = auth.info.image + "?type=large"
          user.password = Devise.friendly_token[0,20]
      end
    end
  end
  
  def like(suitcase)
    likes.find_or_create_by(suitcase_id: suitcase.id)
  end
  
  def unlike(suitcase)
    like = likes.find_by(suitcase_id: suitcase.id)
    like.destroy if like
  end
  
  def like?(suitcase)
    like_suitcases.include?(suitcase)
  end

end