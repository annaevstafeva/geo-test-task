class PlacesController < ApplicationController
  def index
    @places = Place.order(created_at: :desc)
    @saved_distances = SavedDistance.order(updated_at: :desc).includes(:from, :to)
    @saved_distance = SavedDistance.new
  end

  def destroy
    @place= Place.find(params[:id])
    @related_distances = SavedDistance.where(from_id: @place.id).or(SavedDistance.where(to_id: @place.id)).to_a
    @place.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to places_path, notice: "Город и связанные дистанции удалены" }
    end
  end

  private

end
