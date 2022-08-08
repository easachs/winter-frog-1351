class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots

  def fast_plants
    plants.distinct
    .where('plants.days_to_harvest < 100')
  end

  def fast_sorted
    plants
    .where('plants.days_to_harvest < 100')
    .select('plants.*, count(plants.*)')
    .group(:id)
    .distinct
    .order('count desc')
  end
end
