class PlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def destroy
    # require 'pry'; binding.pry
    PlantPlot.find_by(plant: (params[:id])).destroy
    redirect_to '/plots'
  end
end