class Photo < ActiveRecord::Base
  belongs_to :suitcase
  
  if Rails.env.production?
    S3_CREDENTIALS={access_key_id:ENV['S3_ACCESS_KEY_ID'], secret_access_key:ENV['S3_SECRET_KEY'], bucket:"caseshare"}
  end
  
  if Rails.env.production?
    has_attached_file :image, storage: :s3, s3_credentials: S3_CREDENTIALS, 
                              styles: { medium: "300x300>", thumb: "100x100>" },url:":s3_domain_url",
                              path: ":image/:id/:style.:extension"
    validates_attachment_content_type :image, content_type: ["image/jpg", "image/JPG", "image/jpeg", "image/png", "image/gif"]
  else
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  end
  
end
