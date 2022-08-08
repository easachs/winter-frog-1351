class PlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def destroy
    PlantPlot.find_by(plant: (params[:id]), plot: (params[:plot_id])).destroy
    # Plot.find(params[:plot_id]).plant_plots.find_by(plant: (params[:id])).destroy
    redirect_to '/plots'
  end
end