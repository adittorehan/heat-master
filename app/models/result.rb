class Result < ApplicationRecord
  has_secure_token :user_token
  belongs_to :survey
end
