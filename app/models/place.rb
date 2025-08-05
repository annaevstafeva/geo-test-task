class Place < ApplicationRecord
  has_many :from_distances, class_name: 'SavedDistance', foreign_key: 'from_id', dependent: :destroy
  has_many :to_distances, class_name: 'SavedDistance', foreign_key: 'to_id', dependent: :destroy

  before_validation :get_coordinates, on: :create

  validates :city_name, presence: true, uniqueness: true, on: :create

  geocoded_by :address

  def get_coordinates
    data = GeocoderYandexApi.coordinates(self.city_name)

    self.latitude = data[:latitude]
    self.longitude = data[:longitude]
    self.city_name = data[:city_name] if data[:city_name].present?
    self.country_name = data[:country_name] if data[:country_name].present?
  end

  def address
    "#{city_name}, #{country_name}"
  end
end
