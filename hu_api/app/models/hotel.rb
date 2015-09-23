class Hotel < ActiveRecord::Base
  belongs_to :city
  has_many :availabilities

  validates :city_id, presence: true
  validates :name, presence: true, uniqueness: {scope: :city_id}

  scope :by_city_or_hotel_name, ->(name) do
    name = "%#{name}%".upcase
    joins(:city).where('cities.name LIKE UPPER(?) OR hotels.name LIKE UPPER(?)',name,name)
  end

  scope :by_id, ->(id){ eager_load(:city).where(id: id) }

  scope :by_city_id, ->(city_id){ eager_load(:city).where(city_id: city_id) }

  scope :available_from, ->(start_date){ joins(:availabilities).where('availabilities.day >= ?', start_date)}

  scope :available_until, ->(end_date){ joins(:availabilities).where('availabilities.day <= ?', end_date)}

  scope :available_from_until, ->(start_date, end_date) do
    available_from(start_date.to_date).
        available_until(end_date.to_date).
        group('hotels.id').
        having('COUNT(*) >= ?', elapsed_days(start_date, end_date))
  end

  private

  def self.elapsed_days(start_date, end_date)
    (start_date.to_date..end_date.to_date).count
  end

end
