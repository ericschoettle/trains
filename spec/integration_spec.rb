require('capybara/rspec')
require('./app')
require('pry')
require('launchy')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('trains', {:type => :feature}) do
  it "goes to operator page when you click on the operator button" do
    visit('/')
    click_link("I'm an operator")
    expect(page).to have_content('Add a train')
  end

  # it "selects train operator function, adds train, city, and a stop" do
  #   visit('/')
  #   within('#train') {fill_in("name", :with => "Polar Express")}
  #   click_button("Add the train")
  #   expect(page).to have_content('Polar Express')
  #   within('#city') {fill_in("name", :with => "Chicago")}
  #   find('#trainSelect').find(:xpath, 'option[1]').select_option
  #   click_button("Add the city")
  #   expect(page).to have_content('danger')
  #   click_link("urology")
  # end
end
