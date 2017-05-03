# require('capybara/rspec')
# require('./app')
# require('pry')
# Capybara.app = Sinatra::Application
# set(:show_exceptions, false)
#
# describe('trains office', {:type => :feature}) do
#   it "adds a specialty, adds a train to that specialty, adds a city to that train, and clicks on that train to see the city" do
#     visit('/')
#     within('#specialty') {fill_in("name", :with => "urology")}
#     click_button("Add the specialty")
#     expect(page).to have_content('urology')
#     within('#train') {fill_in("name", :with => "danger")}
#     find('#specialtySelect').find(:xpath, 'option[1]').select_option
#     click_button("Add the train")
#     expect(page).to have_content('danger')
#     click_link("urology")
#   end
# end
