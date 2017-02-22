require 'spec_helper'
require 'rails_helper'

describe "the signin and signout process", type: :feature do
  let(:test_user) { FactoryGirl.create(:user) }
       
  it 'test user should exist' do
    expect(User.where(email: test_user.email)).to exist
  end

  it "user signs in" do
    log_in_as(test_user)
    expect(page).to have_link 'Sign out'
  end

  it "user signs out" do
    log_in_as(test_user)
    log_out
    expect(page).to have_link 'Sign in'
  end

  describe "the event options", type: :feature do
    let(:test_user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    context "when the user is logged in" do
      let!(:session) do
        log_in_as test_user
      end

      it "can access their user profile page" do
        visit my_account_user_path(test_user)
        expect(page).to have_current_path(my_account_user_path(test_user))
        expect(page).to have_content("Name:")
        expect(page).to have_content(test_user.full_name)
        expect(page).to have_content("Login:")
        expect(page).to have_content(test_user.email)
        expect(page).to have_content("Phone:")
        expect(page).to have_content(test_user.phone)
        expect(page).to have_link('Edit')
      end

      it "can edit their profile" do
        visit edit_my_account_user_path(test_user)
        fill_in 'First name', with: 'NewName'
        click_button('Update')
        expect(page).to have_current_path(my_account_user_path(test_user))
        expect(page).to have_content("Name:")
        expect(page).to have_content("NewName #{test_user.surname}")
      end

      context "can edit their password" do
        before do
          visit edit_my_account_user_path(test_user)
          fill_in 'Password', with: 'password1'
        end

        it "changes the password if they match" do
          fill_in 'Password confirmation', with: 'password1'
          click_button('Update')
          expect(page).to have_current_path(my_account_user_path(test_user))
        end

        it "does not change the password if they don't match" do
          fill_in 'Password confirmation', with: 'password2'
          click_button('Update')
          expect(page).to have_current_path(my_account_user_path(test_user))
          expect(page).to have_content("doesn't match Password")
        end
      end

      it "can't access the user profile page of another user" do
        visit my_account_user_path(other_user)
        expect(page).to have_current_path(calendar_path)
      end

      it "can't access the edit user profile page of another user" do
        visit edit_my_account_user_path(other_user)
        expect(page).to have_current_path(calendar_path)
      end
    end
  end
end

# setup :activate_authlogic
# UserSession.create!(test_user)
# Capybara.current_session.driver.browser.set_cookie("user_credentials=#{test_user.persistence_token}::#{test_user.send(test_user.class.primary_key)}")
