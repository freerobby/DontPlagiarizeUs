class Detection < ActiveRecord::Base
  belongs_to :user
  has_may :tweets
end