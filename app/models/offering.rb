class Offering < ApplicationRecord
  belongs_to :member, optional: true
end
