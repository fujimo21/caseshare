class Photo < ActiveRecord::Base
  belongs_to :suitcase
  
  if Rails.env.production?
    has_attached_file :image, storage: :s3, s3_credentials: "caseshare/config/s3.yml", 
                              styles: { medium: "300x300>", thumb: "100x100>" },url:":s3_domain_url",
                              path: ":image/:id/:style.:extension"
    validates_attachment_content_type :image, content_type: ["image/jpg", "image/JPG", "image/jpeg", "image/png", "image/gif"]
  else
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  end
  
end
