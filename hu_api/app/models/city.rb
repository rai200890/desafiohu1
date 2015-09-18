class City < ActiveRecord::Base
  has_many :hotels
  validates :name, presence: true, uniqueness: true
end
