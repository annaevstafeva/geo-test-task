class SavedDistance < ApplicationRecord
  belongs_to :from, class_name: "Place"
  belongs_to :to, class_name: "Place"

  before_save :calculate_distance
  before_save :flight_distance_count
  before_save :car_distance_count

  private

  def calculate_distance
    distance = Geocoder::Calculations.distance_between(
      [from.latitude, from.longitude], [to.latitude, to.longitude], units: :km, method: :haversine )
    self.distance = distance
  end


  def flight_distance_count(altitude_km = 10.0)
    earth_radius = 6371.0
    lat1,lon1 = self.from.latitude, self.from.longitude
    lat2, lon2 = self.to.latitude, self.to.longitude

    dlat = (lat2 - lat1) * Math::PI / 180
    dlon = (lon2 - lon1) * Math::PI / 180
    a = Math.sin(dlat/2)**2 + Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) * Math.sin(dlon/2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    ground_distance = earth_radius * c

    adjusted_radius = earth_radius + altitude_km
    km_distance = (ground_distance * adjusted_radius / earth_radius)
    nm_distance = km_distance / 1.852

    self.flight_distance = { km: km_distance, nm: nm_distance }
  end

  def car_distance_count
    from_coords = "#{self.from.longitude},#{self.from.latitude}"
    to_coords = "#{self.to.longitude},#{self.to.latitude}"
    url = "http://router.project-osrm.org/route/v1/driving/#{from_coords};#{to_coords}?overview=false"

    begin
      response = HTTParty.get(url)
      if response.success?
        data = JSON.parse(response.body)
        if data['code'] == 'Ok' && data['routes'].any?
          distance_meters = data['routes'][0]['distance']
          self.car_distance = (distance_meters / 1000.0)
        else
          Rails.logger.error "Ошибка маршрута OSRM: #{data['message'] || 'нет маршрутов'}"
          { error: "Не удалось построить маршрут между выбранными точками." }
        end
      else
        Rails.logger.error "Ошибка HTTP от OSRM при маршруте #{from_coords} → #{to_coords}: #{response.code}"
        return { error: "Не удалось рассчитать маршрут. Попробуйте позже." }
      end
    rescue => e
      Rails.logger.error "Ошибка обращения к OSRM API: #{e.message}"
      { error: "Ошибка при расчёте маршрута. Попробуйте снова позже." }
    end
  end


end
