class CreateOrUpdateSavedDistance
  attr_reader :from_place, :to_place, :saved_distance, :error

  def initialize(from_name, to_name)
    @from_name = from_name
    @to_name = to_name

    @from_place_previously_new = false
    @to_place_previously_new = false
    @existing_found = false
  end

  def call
    resolve_places

    return false if @error

    # Проверяем существование дистанции в любом направлении
    @saved_distance = SavedDistance.find_by(from: @from_place, to: @to_place) ||
      SavedDistance.find_by(from: @to_place, to: @from_place)

    if @saved_distance
      @saved_distance.touch
      @existing_found = true
    else
      @from_place = @to_place if @from_name.eql?(@to_name)
      @saved_distance = SavedDistance.create(from: @from_place, to: @to_place)
    end

    true
  end

  def from_place_previously_new?
    @from_place_previously_new
  end

  def to_place_previously_new?
    @to_place_previously_new
  end

  def existing_was_found?
    @existing_found
  end

  private

  def resolve_places
    if @from_name.strip.casecmp?(@to_name.strip)
      @from_place = @to_place = Place.find_by_city_name(@from_name)

      unless @from_place
        begin
          from_data = GeocoderYandexApi.coordinates(@from_name)
        rescue => e
          @error = "Ошибка при обращении к геокодеру: #{e.message}"
        end

        if from_data[:error]
          @error = from_data[:error]
          return
        end
        @from_place = @to_place = Place.create(from_data)
        @from_place_previously_new = @to_place_previously_new = true
      end

      return
    end

    @from_place = Place.find_by_city_name(@from_name)
    unless @from_place
      begin
        from_data = GeocoderYandexApi.coordinates(@from_name)
      rescue => e
        @error = "Ошибка при получении данных из геокодера: #{e.message}"
      end
      if from_data[:error]
        @error = from_data[:error]
        return
      end
      @from_place = Place.create(from_data)
      @from_place_previously_new = true
    end

    @to_place = Place.find_by_city_name(@to_name)
    unless @to_place
      begin
        to_data = GeocoderYandexApi.coordinates(@to_name)
      rescue => e
        @error = "Ошибка при получении данных из геокодера: #{e.message}"
      end
      if to_data[:error]
        @error = to_data[:error]
        return
      end
      @to_place = Place.create(to_data)
      @to_place_previously_new = true
    end
  end

end
