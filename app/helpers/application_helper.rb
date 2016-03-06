module ApplicationHelper
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase 
		if user.image
			user.image
		else
			"https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=150"
		end
	end
  
  def default_meta_tags
  {
    title:       "CaseShared | スーツケースを貸そう！借りよう！",
    description: "素敵なスーツケースを貸す/借りるサービスです。良い旅にしましょう！",
    keywords:    "スーツケース,キャリーケース,キャリーバッグ,レンタル,シェアリングエコノミー, シェア",
    icon: image_url("favicon.ico"), # favicon
    noindex: ! Rails.env.production?, # production環境以外はnoindex  
    charset: "UTF-8",
    # OGPの設定
    og: {
      title: "CaseShared | スーツケースを貸そう！借りよう！",
      type: "website",
      url: "http://caseshare.herokuapp.com/",
      site_name: "CaseShared",
      image: image_url("/assets/OGP.jpg"),
      description: "素敵なスーツケースを貸す/借りるサービスです。良い旅にしましょう！",
      locale: "ja_JP"
    },
    twitter: {
        card: "summary",
        site: "@2_1_f",
    }
  }
  end
  
end
