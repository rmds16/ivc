require 'spec_helper'
require 'rails_helper'

describe "the calendar options", type: :feature do
  let(:test_user) { FactoryGirl.create(:user) }
       
  it 'test user should exist' do
    expect(User.where(email: test_user.email)).to exist
  end

  it "calendar shows an event", js: true do
    FactoryGirl.create(:event)
    visit calendar_path
    expect(page).to have_content 'Test Event'
  end

  context "click on an event" do
    it "user is logged in", js: true do
      calendar_event = FactoryGirl.create(:event)
      as_user(test_user) do
        visit calendar_path
        click_on "Test Event"
        expect(page).to have_current_path(event_path(calendar_event))
      end
    end

    it "user is not logged in", js: true do
      FactoryGirl.create(:event)
      visit calendar_path
      expect(page).to have_content("Test Event")
      expect(page).to have_link("Test Event")
      click_on "Test Event"
      expect(page).to have_content 'Please sign in to continue'
      expect(page).to have_current_path(signin_path)
    end
  end
end
