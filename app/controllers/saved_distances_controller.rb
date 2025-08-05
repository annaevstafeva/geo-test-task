class SavedDistancesController < ApplicationController
  def new
    @saved_distance = SavedDistance.new
  end

  def create
    empty_lists = Place.none?

    # if params[:saved_distance][:from].eql?(params[:saved_distance][:to])
    #   return render_form_with_error("Введено два одинаковых названия", SavedDistance.new)
    # end

    service = CreateOrUpdateSavedDistance.new(params[:saved_distance][:from], params[:saved_distance][:to])

    unless service.call
      return render_form_with_error(service.error, SavedDistance.new)
    end

    @saved_distance = service.saved_distance
    @from = service.from_place
    @to = service.to_place

    from_present = !service.from_place_previously_new?
    to_present = !service.to_place_previously_new?

    if service.existing_was_found?
      return render turbo_stream: build_streams(@saved_distance, @from, @to, from_present, to_present)
    end

    if @saved_distance.persisted?
      streams = build_streams(@saved_distance, @from, @to, from_present, to_present)
      streams << replace_empty_state(empty_lists)
      render turbo_stream: streams.flatten
    else
      render_form_with_error(@saved_distance.errors.full_messages.join(', '), @saved_distance)
    end
  end

  def destroy
    @saved_distance = SavedDistance.find(params[:id])
    @saved_distance.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to saved_distances_path, notice: "Расстояние удалено" }
    end
  end

  private

  def replace_empty_state(empty_lists)
    streams = []
    streams << turbo_stream.replace('empty_state_places', partial: 'places/place_header') if empty_lists
    streams << turbo_stream.replace('empty_state_distance', partial: 'saved_distances/distance_header') if empty_lists
    streams
  end

  def render_form_with_error(error, saved_distance)
    render turbo_stream: turbo_stream.replace('distance_form', partial: 'saved_distances/new', locals: { saved_distance: saved_distance, error: error })
  end

  def build_streams(distance, from_place, to_place, from_present, to_present)
    streams = []

    streams << turbo_stream.prepend('distances_list', partial: 'saved_distances/distance_item', locals: { distance: distance })
    streams << turbo_stream.replace('search_result', partial: 'saved_distances/search_result', locals: { result: distance })
    streams << turbo_stream.replace('distance_form', partial: 'saved_distances/new', locals: { saved_distance: SavedDistance.new })
    streams << turbo_stream.prepend('places_list', partial: 'places/place_item', locals: { place: from_place }) unless from_present
    streams << turbo_stream.prepend('places_list', partial: 'places/place_item', locals: { place: to_place }) unless to_present

    streams
  end

  def saved_distance_params
    params.require(:saved_distance).permit(:distance, :from, :to)
  end
end
