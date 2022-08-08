require 'rails_helper'

RSpec.describe 'plots index' do
  it 'lists all plot numbers with names of plots plants' do
    turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
    other_garden = Garden.create!(name: 'Main Street Garden', organic: false)

    plot_1 = turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
    plot_2 = turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
    plot_3 = library_garden.plots.create!(number: 2, size: "Small", direction: "South")
    plot_4 = other_garden.plots.create!(number: 738, size: "Medium", direction: "West")

    tomato = Plant.create!(name: "Tomato", description: "red", days_to_harvest: 30)
    squash = Plant.create!(name: "Squash", description: "yellow", days_to_harvest: 40)
    lettuce = Plant.create!(name: "Lettuce", description: "leafy", days_to_harvest: 50)
    cucumber = Plant.create!(name: "Cucumber", description: "green", days_to_harvest: 60)
    pepper = Plant.create!(name: "Pepper", description: "spicy", days_to_harvest: 70)
    melon = Plant.create!(name: "Melon", description: "juicy", days_to_harvest: 80)

    PlantPlot.create(plant: tomato, plot: plot_1)
    PlantPlot.create(plant: squash, plot: plot_1)
    PlantPlot.create(plant: lettuce, plot: plot_1)
    PlantPlot.create(plant: cucumber, plot: plot_1)
    PlantPlot.create(plant: tomato, plot: plot_2)
    PlantPlot.create(plant: pepper, plot: plot_2)
    PlantPlot.create(plant: squash, plot: plot_3)
    PlantPlot.create(plant: melon, plot: plot_4)

    visit '/plots'

    within "#plot-25" do
      expect(page).to have_content("Plot 25")
      expect(page).to have_content("Tomato")
      expect(page).to have_content("Squash")
      expect(page).to have_content("Lettuce")
      expect(page).to have_content("Cucumber")
      expect(page).to_not have_content("Pepper")
      expect(page).to_not have_content("Melon")
    end

    within "#plot-26" do
      expect(page).to have_content("Plot 26")
      expect(page).to have_content("Tomato")
      expect(page).to have_content("Pepper")
      expect(page).to_not have_content("Lettuce")
      expect(page).to_not have_content("Melon")
    end

    within "#plot-2" do
      expect(page).to have_content("Plot 2")
      expect(page).to have_content("Squash")
      expect(page).to_not have_content("Lettuce")
      expect(page).to_not have_content("Cucumber")
      expect(page).to_not have_content("Melon")
    end

    within "#plot-738" do
      expect(page).to have_content("Plot 738")
      expect(page).to have_content("Melon")
      expect(page).to_not have_content("Squash")
      expect(page).to_not have_content("Lettuce")
      expect(page).to_not have_content("Cucumber")
    end
  end
end