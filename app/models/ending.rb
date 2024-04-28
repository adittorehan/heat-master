class Ending < ApplicationRecord
  belongs_to :survey, touch: true
end
