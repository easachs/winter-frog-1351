require 'rails_helper'

RSpec.describe 'garden show' do
  it 'lists unique plants that take less than 100 days' do
    turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    library_garden = Garden.create!(name: 'Public Library Garden', organic: true)

    plot_1 = turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
    plot_2 = turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
    plot_3 = library_garden.plots.create!(number: 2, size: "Small", direction: "South")

    tomato = Plant.create!(name: "Tomato", description: "red", days_to_harvest: 30)
    squash = Plant.create!(name: "Squash", description: "yellow", days_to_harvest: 100)
    lettuce = Plant.create!(name: "Lettuce", description: "leafy", days_to_harvest: 120)
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
    PlantPlot.create(plant: melon, plot: plot_3)

    visit "/gardens/#{turing_garden.id}"

    expect(page).to have_content("Turing Community Garden")
    within "#plants" do
      expect(page).to have_content("Tomato", count: 1)
      expect(page).to have_content("Cucumber", count: 1)
      expect(page).to have_content("Pepper", count: 1)
      expect(page).to_not have_content("Squash")
      expect(page).to_not have_content("Lettuce")
      expect(page).to_not have_content("Melon")
    end

    visit "/gardens/#{library_garden.id}"

    expect(page).to have_content("Public Library Garden")
    within "#plants" do
      expect(page).to have_content("Melon", count: 1)
      expect(page).to_not have_content("Squash")
    end
  end
end