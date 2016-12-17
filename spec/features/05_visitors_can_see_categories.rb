require 'rails_helper'

# [] A restaurant can have many categories.
# [] I should see the name of the category at the top of the page
#   [] I should be able to see all restaurants belonging to a specific category
#   [] A timestamp for when it was created
# [] Visiting the `/category/1` path should also include all reviews for a restaurant with ID = 1.

feature "visitor sees the name of the category at the top of the restaurant page" do
  scenario "sees reviews for specific restaurant" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '02111' :category 'Chinese')

    visit restaurant_path(dumpling_king)

    expect(page).to have_content dumpling_king.category
  end

  scenario "does not see other reviews for other restaurants" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '02111')
    rock_bottom = Restaurant.create(name: "Rock Bottom", address: "Beach streer", city: "Boston", state: "MA", zip: "02112")
    

    visit restaurant_path(rock_bottom)

    expect(page).to have_content rock_bottom.name
    expect(page).to have_content review_for_rock.body

    expect(page).not_to have_content dumpling_king.name
    expect(page).not_to have_content review_for_dumplings.rating
    expect(page).not_to have_content review_for_dumplings.body
  end
end
