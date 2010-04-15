class User < TwitterAuth::GenericUser
  has_one :detection
  has_many :tweets
end
