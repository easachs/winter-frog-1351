class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots

  def fast_plants
    plants.distinct
    .where('plants.days_to_harvest < 100')
  end
end
