class City < ActiveRecord::Base
  has_many :hotels
  validates :name, presence: true, uniqueness: true

  scope :by_city_name, ->(name) do
    name = "%#{name}%".upcase
    where('name LIKE UPPER(?)',name)
  end

end
