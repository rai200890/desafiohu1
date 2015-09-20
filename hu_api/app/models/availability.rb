class Availability < ActiveRecord::Base
  belongs_to :hotel
  validates :hotel_id, presence: true
  validates :day, presence: true, uniqueness: {scope: :hotel_id}
end
