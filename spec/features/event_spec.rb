require 'spec_helper'
require 'rails_helper'

describe "create an event", type: :feature do
  let(:test_user) { FactoryGirl.create(:user) }

  context "when the user is logged in" do
    let!(:session) do
      log_in_as test_user
    end

    it "can create an event" do
      visit new_event_path
      fill_in 'Title', with: 'Test New Event'
      fill_in 'Location', with: 'New event location'
      fill_in 'Post Code', with: 'AB4 5LE'
      fill_in 'Description', with: 'New event description'
      select test_user.full_name, from: "Organiser"
      fill_in 'Organiser phone', with: '0123456789'
      click_button 'Create'
      expect(page).to have_current_path(calendar_path)
    end

    it "raises an error if the title is missing" do
      visit new_event_path
      fill_in 'Location', with: 'New event location'
      fill_in 'Post Code', with: 'AB4 5LE'
      fill_in 'Description', with: 'New event description'
      select test_user.full_name, from: "Organiser"
      fill_in 'Organiser phone', with: '0123456789'
      click_button 'Create'
      expect(page).to have_current_path(events_path)
      expect(page).to have_content("Title can't be blank")
    end

    it "raises an error if the organiser is missing" do
      visit new_event_path
      fill_in 'Title', with: 'Test New Event'
      fill_in 'Location', with: 'New event location'
      fill_in 'Post Code', with: 'AB4 5LE'
      fill_in 'Description', with: 'New event description'
      fill_in 'Organiser phone', with: '0123456789'
      select "", from: "Organiser"
      click_button 'Create'
      expect(page).to have_current_path(events_path)
      expect(page).to have_content("Organiser please select an organiser")
    end
  end

  it "does not allow an event to be created if the user is not logged in" do
    visit new_event_path
    expect(page).to have_current_path(signin_path)
  end
end

describe "the event options", type: :feature do
  let(:test_user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:test_event) { FactoryGirl.create(:event) }

  context "when the user is logged in" do
    let!(:session) do
      log_in_as test_user
    end

    it "can access the event if the user is logged in" do
      Timecop.freeze(DateTime.parse("2017-02-11 20:00")) do
        test_event.update_attributes(start_date: DateTime.now, book_by_date: DateTime.now + 1.day)
        visit event_path(test_event)
        expect(page).to have_current_path(event_path(test_event))
        expect(page).to have_content("Test Event")
        expect(page).to have_content("Start:")
        expect(page).to have_content("February 11, 2017 20:00")
        expect(page).to have_content("Location:")
        expect(page).to have_content("Location description")
        expect(page).to have_content("Post code:")
        expect(page).to have_content("ET1 3ST")
        expect(page).to have_content("Book by date:")
        expect(page).to have_content("February 12, 2017")
        expect(page).to have_content("Description:")
        expect(page).to have_content("A public description")
        expect(page).to have_content("Organiser:")
        expect(page).to have_content(test_user.full_name)
      end
    end

    it "can sign up to an event" do
      visit event_path(test_event)
      click_button("Attend Event")
      expect(page).to have_button("Book Out")
    end

    it "can book out of an event" do
      test_event.attendees << test_user
      visit event_path(test_event)
      click_button("Book Out")
      expect(page).to have_button("Attend Event")
    end

    context "the user is not the organiser or creator" do
      before do
        test_event.update_attributes(organiser_id: other_user.id, second_organiser_id: nil, user_id: other_user.id)
      end

      it "does not have the edit and delete links" do
        visit event_path(test_event)
        expect(page).to_not have_content("Attendees")
        expect(page).to_not have_link("Edit")
        expect(page).to_not have_link("Delete")
      end

      context "there is a signed up user" do
        before do
          test_event.attendees << other_user
          visit event_path(test_event)
        end

        it "does not show the signed up user" do
          expect(page).to_not have_content("Count: 1")
          expect(page).to_not have_link("Remove")
        end

        it "does not allow users to be removed" do
          visit event_remove_attendee_path(test_event, {user_id: other_user.id})
          expect(page).to have_current_path(signin_path)
        end
      end
    end

    context "the user is the event organiser" do
      before do
        test_event.update_attributes(organiser_id: test_user.id, second_organiser_id: nil, user_id: other_user.id)
      end

      it "has the edit and delete links" do
        visit event_path(test_event)
        expect(page).to have_content("Attendees")
        expect(page).to have_link("Edit")
        expect(page).to have_link("Delete")
      end

      context "there is a signed up user" do
        before do
          test_event.attendees << other_user
          visit event_path(test_event)
        end

        it "shows the signed up user" do
          expect(page).to have_content("Count: 1")
          expect(page).to have_link("Remove")
        end

        it "can remove users from events" do
          click_link("Remove")
          expect(page).to have_content("Count: 0")
        end
      end
    end

    context "the user is the event second_organiser" do
      before do
        test_event.update_attributes(organiser_id: other_user.id, second_organiser_id:test_user.id, user_id: other_user.id)
      end

      it "has the edit and delete links" do
        visit event_path(test_event)
        expect(page).to have_content("Attendees")
        expect(page).to have_link("Edit")
        expect(page).to have_link("Delete")
      end

      context "there is a signed up user" do
        before do
          test_event.attendees << other_user
          visit event_path(test_event)
        end

        it "shows the signed up user" do
          expect(page).to have_content("Count: 1")
          expect(page).to have_link("Remove")
        end

        it "can remove users from events" do
          click_link("Remove")
          expect(page).to have_content("Count: 0")
        end
      end
    end

    context "the user is the event original creator" do
      before do
        test_event.update_attributes(organiser_id: other_user.id, second_organiser_id: nil, user_id: test_user.id)
      end

      it "has the edit and delete links" do
        visit event_path(test_event)
        expect(page).to have_content("Attendees")
        expect(page).to have_link("Edit")
        expect(page).to have_link("Delete")
      end

      context "there is a signed up user" do
        before do
          test_event.attendees << other_user
          visit event_path(test_event)
        end

        it "shows the signed up user" do
          expect(page).to have_content("Count: 1")
          expect(page).to have_link("Remove")
        end

        it "can remove users from events" do
          click_link("Remove")
          expect(page).to have_content("Count: 0")
        end
      end
    end
  end

  context "when the admin user is logged in" do
    let(:admin_user) { FactoryGirl.create(:user) }
    let!(:session) do
      log_in_as admin_user
    end

    before do
      admin_user.update_attribute(:admin, true)
    end

    it "can access the event if the user is logged in" do
      Timecop.freeze(DateTime.parse("2017-02-11 20:00")) do
        test_event.update_attributes(start_date: DateTime.now, book_by_date: DateTime.now + 1.day)
        visit event_path(test_event)
        expect(page).to have_current_path(event_path(test_event))
        expect(page).to have_content("Test Event")
        expect(page).to have_content("Start:")
        expect(page).to have_content("February 11, 2017 20:00")
        expect(page).to have_content("Location:")
        expect(page).to have_content("Location description")
        expect(page).to have_content("Post code:")
        expect(page).to have_content("ET1 3ST")
        expect(page).to have_content("Book by date:")
        expect(page).to have_content("February 12, 2017")
        expect(page).to have_content("Description:")
        expect(page).to have_content("A public description")
        expect(page).to have_content("Organiser:")
        expect(page).to have_content(admin_user.full_name)
      end
    end

    it "has an edit link" do
      visit event_path(test_event)
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
    end

    context "there is a signed up user" do
      before do
        test_event.attendees << other_user
        visit event_path(test_event)
      end

      it "shows the signed up user" do
        expect(page).to have_content("Count: 1")
        expect(page).to have_link("Remove")
      end

      it "can remove users from events" do
        click_link("Remove")
        expect(page).to have_content("Count: 0")
      end
    end
  end

  it "cannot access the event if the user is not logged in" do
    visit event_path(test_event)
    expect(page).to have_current_path(signin_path)
  end
end