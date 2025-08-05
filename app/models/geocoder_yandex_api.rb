class GeocoderYandexApi
  include HTTParty
  base_uri 'https://geocode-maps.yandex.ru'

  def self.find_valid_result_by_kind(results)
    results.find do |result|
      geo = result['GeoObject']
      kind = geo.dig('metaDataProperty', 'GeocoderMetaData', 'kind')
      kind.eql?('locality') || kind.eql?('province')
    end
  end

  def self.collect_data_from_valid_result(valid_result)
    geo = valid_result['GeoObject']
    country = geo.dig("metaDataProperty", "GeocoderMetaData", "AddressDetails", "Country", "CountryName")
    points = geo['Point']['pos'].split(' ').map(&:to_f).reverse
    city_name = geo.dig("metaDataProperty", "GeocoderMetaData", "Address", "formatted").split(', ').last
    {latitude: points[0], longitude: points[1], country_name: country, city_name: city_name}
  end

  def self.coordinates(city)
    begin
      response = get('/1.x/', {
        query: {
          geocode: city,
          apikey: '69bc93e5-5ef5-4f28-b80e-faa33e211e5b',
          lang: 'ru_RU',
          format: 'json',
          kind: 'locality'
        }
      })
    rescue => e
      Rails.logger.error "Ошибка подключения к Yandex API: #{e.message}"
      return { error: "Не удалось подключиться к геосервису для запроса \"#{city}\"." }
    end

    if response.success?
      begin
        json = JSON.parse(response.body)
        results = json.dig('response', 'GeoObjectCollection', 'featureMember')
        if results.blank?
          msg = "Посчитать расстояние невозможно. Введено некорректное значение \"#{city}\" в одно из полей."
          Rails.logger.error "Ошибка при поиске города через YANDEX API. #{msg}"
          return { error: msg }
        end

        valid_result = find_valid_result_by_kind(results)

        if valid_result.blank?
          msg = "Населённый пункт с названием \"#{city}\" не найден."
          Rails.logger.error msg
          return { error: msg }
        end

        collect_data_from_valid_result(valid_result)
      rescue => e
        Rails.logger.error "Ошибка парсинга ответа Yandex API для \"#{city}\": #{e.message}"
        { error: "Ошибка при обработке данных для \"#{city}\". Попробуйте снова." }
      end
    else
      Rails.logger.error "Ошибка от Yandex API при запросе \"#{city}\": #{response.code}"
      return { error: "Ошибка при обработке запроса для \"#{city}\". Попробуйте позже." }
    end

  end
end
